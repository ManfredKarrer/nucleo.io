package io.nucleo.codegeneration.di;

import org.as3commons.asblocks.ASFactory;
import org.as3commons.asblocks.IASWriter;
import org.as3commons.asblocks.dom.*;
import org.as3commons.asblocks.impl.ASTASClassType;
import org.as3commons.asblocks.impl.ASTASProject;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

////////////////////////////////////////////////////////////////////////////////
// This project use the as3-commons-jasblocks project which is based on antlr:
// @see: https://github.com/teotigraphix/as3-commons-jasblocks
// @see: http://www.antlr.org/
////////////////////////////////////////////////////////////////////////////////
public class ConstructorParameterBuilder {

    public static final String QUALIFIED_CONFIG_CLASS_NAME = "io.nucleo.inject.AConfig";
    public static final String CONST_PARAM_CLASS_NAME = "ConstructorParameters";
    public static final String CONST_PARAM_SUPER_CLASS = "AConstructorParameters";
    public static final String CONST_PARAM_SUPER_CLASS_PACKAGE = "io.nucleo.inject";

    public static final String FS = System.getProperty("file.separator");


    private List<String> sourcePaths;
    private String targetPath;
    private ASFactory factory;
    private List<String> mappingKeys;

    /**
     * @param sourcePaths List of absolute source paths.
     * @param targetPath  Absolute path of target directory where the ConstructorParameters.as class
     *                    will be written to. The package structure will be generated automatically.
     */
    public ConstructorParameterBuilder(List<String> sourcePaths, String targetPath) {
        this.sourcePaths = sourcePaths;
        this.targetPath = targetPath;
    }

    public void build() {
        ASTASProject project = createProject();
        project.readAll();
        List<IASCompilationUnit> configClassCompilationUnits = findConfigClasses(project);
        mappingKeys = ConfigClassParser.getMappingKeys(configClassCompilationUnits);
        String packageName = getPackageOfConfigClass(configClassCompilationUnits);
        IASCompilationUnit compilationUnit = createCompilationUnit(packageName);
        IASClassType classType = (IASClassType) compilationUnit.getType();
        createClassContent(compilationUnit.getPackage(), classType, project.getCompilationUnits());
        writeClassToFile(targetPath, compilationUnit);
    }


    private ASTASProject createProject() {
        factory = new ASFactory();
        ASTASProject project = new ASTASProject(factory);
        for (Iterator<String> iterator = sourcePaths.iterator(); iterator.hasNext(); ) {
            String sourcePath = iterator.next();
            project.addSourcePath(sourcePath);
        }
        return project;
    }

    /**
     * Find all Config classes and their subclasses
     *
     * @param project
     * @return
     */
    private List<IASCompilationUnit> findConfigClasses(ASTASProject project) {
        List<IASCompilationUnit> compilationUnits = project.getCompilationUnits();
        List<IASCompilationUnit> configClassCompilationUnits = new ArrayList<IASCompilationUnit>();

        IASCompilationUnit unit = project.newClass(QUALIFIED_CONFIG_CLASS_NAME);
        configClassCompilationUnits.add(unit);

        IASCompilationUnit configClassCompilationUnit = findConfigClass(compilationUnits,
                                                                        configClassCompilationUnits);
        while (configClassCompilationUnit != null) {
            configClassCompilationUnits.add(configClassCompilationUnit);
            configClassCompilationUnit = findConfigClass(compilationUnits, configClassCompilationUnits);
        }

        return configClassCompilationUnits;
    }

    private IASCompilationUnit findConfigClass(List<IASCompilationUnit> compilationUnits,
                                               List<IASCompilationUnit> configClassCompilationUnits) {
        outer:
        for (Iterator<IASCompilationUnit> iterator = compilationUnits.iterator(); iterator.hasNext(); ) {
            IASCompilationUnit compilationUnit = iterator.next();
            if (compilationUnit != null) {
                // check if this compilationUnit is already in our cached configClassCompilationUnits list
                // if so skip this
                for (Iterator<IASCompilationUnit> configClassCUsIterator = configClassCompilationUnits.iterator();
                     configClassCUsIterator.hasNext(); ) {
                    IASCompilationUnit configClassCompilationUnit = configClassCUsIterator.next();
                    if (configClassCompilationUnit != null && compilationUnit.equals(configClassCompilationUnit)) {
                        continue outer;
                    }
                }

                IASType type = compilationUnit.getType();
                if (type instanceof ASTASClassType) {
                    List<IASImportStatement> imports = compilationUnit.getPackage().getImports();
                    String packageName = compilationUnit.getPackageName();
                    ASTASClassType classType = (ASTASClassType) type;
                    String superClass = classType.getSuperClass();

                    // TODO: Need to add support for swc files as well, that is not possible with src code
                    // introspection only.
                    // It needs other tools to inspect compiled files (http://www.flagstonesoftware.com/transform/)
                    // At the moment we only check for configs extending the default AConfig superclass not for
                    // configs implementing the interface (IConfig).
                    // We expect that all config classes are extending AConfig and not using an own implementation
                    // of IConfig.
                    boolean isConfigClass = ConfigClassParser.isClassExtendingAnyConfigClass(imports,
                                                                                             packageName,
                                                                                             superClass,
                                                                                             configClassCompilationUnits);
                    if (isConfigClass) {
                        return compilationUnit;
                    }
                }
            }
        }
        return null;
    }

    private String getPackageOfConfigClass(List<IASCompilationUnit> configClassCompilationUnits) {
        String configClassPackageName = null;
        String packageName = null;
        for (Iterator<IASCompilationUnit> iterator = configClassCompilationUnits.iterator(); iterator.hasNext(); ) {
            IASCompilationUnit compilationUnit = iterator.next();
            packageName = compilationUnit.getPackageName();
            if (configClassPackageName != null && !configClassPackageName.equals(packageName)) {
                try {
                    // Convention/Restriction: all config classes of a project must be in same package
                    // this restriction makes life easier, but should be removed later...
                    throw new Exception("All Config classes must be in the same package.");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return packageName;
    }

    private void createClassContent(IASPackage asPackage,
                                    IASClassType classType,
                                    List<IASCompilationUnit> compilationUnits) {
        classType.setSuperClass(CONST_PARAM_SUPER_CLASS);
        List<String> importList = new ArrayList<String>();
        importList.add(CONST_PARAM_SUPER_CLASS_PACKAGE + "." + CONST_PARAM_SUPER_CLASS);
        IASMethod configMethod = createConfigMethod(classType);
        addConfigMethodBody(configMethod, compilationUnits, importList);
        addImports(importList, asPackage);
    }

    private void writeClassToFile(String targetPath, IASCompilationUnit compilationUnit) {
        IASWriter writer = factory.newWriter();
        StringWriter out = new StringWriter();
        try {
            writer.write(out, compilationUnit);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String result = out.toString();
        String packageName = compilationUnit.getPackage().getName();
        String packagePath = packageName.replace(".", FS);
        String filePath = targetPath + FS + packagePath + FS + CONST_PARAM_CLASS_NAME + ".as";

        // create missing directories if needed
        File file = new File(filePath);
        file.getParentFile().mkdirs();

        try {
            FileWriter fileWriter = new FileWriter(filePath, false);
            fileWriter.write(result);
            fileWriter.flush();
            fileWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(result);
    }


    private IASCompilationUnit createCompilationUnit(String packageName) {
        String fullQualifiedClassName = packageName + "." + CONST_PARAM_CLASS_NAME;
        IASCompilationUnit compilationUnit = factory.newClass(fullQualifiedClassName);
        return compilationUnit;
    }

    private IASMethod createConfigMethod(IASClassType classType) {
        IASMethod configMethod = classType.newMethod("config", Visibility.PROTECTED, "void");
        configMethod.setOverride(true);
        return configMethod;
    }

    private void addConfigMethodBody(IASMethod configMethod,
                                     List<IASCompilationUnit> compilationUnits,
                                     List<String> importList) {
        List<String> constructorParameterStatements = getConstructorParameterStatements(compilationUnits,
                                                                                        importList);
        addStatements(configMethod, constructorParameterStatements);
    }


    public List<String> getConstructorParameterStatements(List<IASCompilationUnit> compilationUnits,
                                                          List<String> importList) {
        List<String> constructorParameterStatements = new ArrayList<String>();
        for (Iterator<IASCompilationUnit> iterator = compilationUnits.iterator(); iterator.hasNext(); ) {
            IASCompilationUnit compilationUnit = iterator.next();
            if (compilationUnit != null) {
                String constructorParameterStatement = getConstructorParameterStatement(compilationUnit, importList);
                if (constructorParameterStatement != null)
                    constructorParameterStatements.add(constructorParameterStatement);
            }
        }
        return constructorParameterStatements;
    }


    private String getConstructorParameterStatement(IASCompilationUnit compilationUnit, List<String> importList) {
        String constructorParameterStatement = null;
        List<IASParameter> parameters = getConstructorParameters(compilationUnit);
        if (parameters != null) {
            IASClassType classType = (IASClassType) compilationUnit.getType();
            String className = classType.getName();
            List<String> importSubList = new ArrayList<String>();
            List<IASImportStatement> imports = compilationUnit.getPackage().getImports();
            String packageName = compilationUnit.getPackage().getPackageName();
            importSubList.add(packageName + ".*");
            for (Iterator<IASParameter> parametersIterator = parameters.iterator(); parametersIterator.hasNext(); ) {
                IASParameter parameter = parametersIterator.next();
                String parameterType = parameter.getType();
                String parameterName = parameter.getName();
                String parameterEntry;
                boolean isParameterDefinedInMappingKeys = isDefinedInMappingKeys(parameterName, mappingKeys)
                        || isDefinedInMappingKeys(parameterType, mappingKeys);
                if (isParameterDefinedInMappingKeys) {
                    if (constructorParameterStatement == null) {
                        constructorParameterStatement = "constructorParameterKeys[" + className + "] = [";
                    }
                    if (isDefinedInMappingKeys(parameterName, mappingKeys) && parameterType instanceof String) {
                        // use a parameter name as key
                        parameterEntry = "\"" + parameterName + "\"";
                    } else {
                        // use the parameter type as key
                        parameterEntry = parameterType;
                        addImportsForParam(parameterType, imports, importSubList);
                    }

                    constructorParameterStatement += parameterEntry;
                    if (parametersIterator.hasNext()) {
                        constructorParameterStatement += ", ";
                    } else {
                        constructorParameterStatement += "];";
                    }
                }
            }
            if (constructorParameterStatement != null) {
                importList.addAll(importSubList);
            }
        }
        return constructorParameterStatement;
    }

    private List<IASParameter> getConstructorParameters(IASCompilationUnit compilationUnit) {
        List<IASParameter> result = null;
        IASType type = compilationUnit.getType();
        if (type instanceof ASTASClassType) {
            IASClassType classType = (IASClassType) type;
            String className = classType.getName();
            IASMethod constructor = classType.getMethod(className);
            if (constructor != null) {
                List<IASParameter> parameters = constructor.getParameters();
                if (parameters != null && parameters.size() > 0) {
                    result = parameters;
                }
            }
        }
        return result;
    }

    private boolean isDefinedInMappingKeys(String key, List<String> mappingKeys) {
        for (Iterator<String> iterator = mappingKeys.iterator(); iterator.hasNext(); ) {
            String mappingKey = iterator.next();
            if (mappingKey.equals(key)) {
                return true;
            }
        }
        return false;
    }


    /**
     * Add imports used matching the typeName and wildcard imports.
     * Handling of imports is not bulletproof for some syntactically correct but unusual cases.
     * TODO need to be made bulletproof in an upcoming version.
     *
     * @param typeName      The type (class, interface) used
     * @param imports       IASImportStatement imports List
     * @param importSubList Filtered imports List as Strings
     */
    private void addImportsForParam(String typeName,
                                    List<IASImportStatement> imports,
                                    List<String> importSubList) {

        for (Iterator<IASImportStatement> iterator = imports.iterator(); iterator.hasNext(); ) {
            IASImportStatement importStatement = iterator.next();
            if (importStatement != null) {
                String importString = importStatement.getTargetString();
                if (importString.endsWith(typeName)) {
                    importSubList.add(importString);
                    break;
                } else if (importString.endsWith(".*")) {
                    importSubList.add(importString);
                    break;
                }
            }
        }
    }


    private void addStatements(IASMethod method, List<String> constructorParameterStatements) {
        if (constructorParameterStatements != null) {
            for (Iterator<String> iterator = constructorParameterStatements.iterator(); iterator.hasNext(); ) {
                String statementString = iterator.next();
                IASStatement statement = factory.newStatement(statementString);
                method.addStatement(statement);
            }
        }
    }

    private void addImports(List<String> importList, IASPackage pack) {
        removeDuplicates(importList);

        for (Iterator<String> iterator = importList.iterator(); iterator.hasNext(); ) {
            String importAsString = iterator.next();
            pack.parseImport(importAsString);
        }
    }

    private void removeDuplicates(List<String> list) {
        HashSet<String> hashSet = new HashSet<String>(list);
        list.clear();
        list.addAll(hashSet);
    }
}
