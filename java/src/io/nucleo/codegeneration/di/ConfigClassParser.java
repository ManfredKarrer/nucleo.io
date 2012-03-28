package io.nucleo.codegeneration.di;

import org.as3commons.asblocks.dom.*;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ConfigClassParser {

    // new line
    public static final String NL = System.getProperty("line.separator");

    /**
     * @param imports
     * @param packageName
     * @param superClassName
     * @param configCompilationUnits
     * @return
     */
    public static boolean isClassExtendingAnyConfigClass(List<IASImportStatement> imports,
                                                         String packageName,
                                                         String superClassName,
                                                         List<IASCompilationUnit> configCompilationUnits
                                                        ) {

        for (Iterator<IASCompilationUnit> iterator = configCompilationUnits.iterator(); iterator.hasNext(); ) {
            IASCompilationUnit configCompilationUnit = iterator.next();
            IASType type = configCompilationUnit.getType();
            String targetSuperClassName = type.getName();
            String targetSuperClassPackageName = configCompilationUnit.getPackageName();
            if (isExtendingSuperClass(imports,
                                      packageName,
                                      superClassName,
                                      targetSuperClassName,
                                      targetSuperClassPackageName))
                return true;
        }

        return false;
    }

    /**
     * Checks if the target super class is the one the class is extending
     *
     * @param imports                     A list of all imports used in this class.
     * @param classPackageName            The class package name.
     * @param givenSuperClassName         The super class used in the class after the "extends" keyword.
     * @param targetSuperClassName        The super class we are looking for.
     * @param targetSuperClassPackageName The package name of the super class we are looking for.
     * @return
     */
    public static boolean isExtendingSuperClass(List<IASImportStatement> imports,
                                                String classPackageName,
                                                String givenSuperClassName,
                                                String targetSuperClassName,
                                                String targetSuperClassPackageName
                                               ) {

        // if it is a config class it must extend AConfig
        // we check for the correct full qualifies class name in the possible import variants
        // case 1: import with qualifies class name like: import io.nucleo.inject.AConfig;
        // case 2: import with wildcard like: import io.nucleo.inject.*;
        // case 3: no import needed because class is in the same package

        // superclass must exist and has to be the passed config class (targetSuperClassName)
        if (givenSuperClassName == null || !givenSuperClassName.equals(targetSuperClassName)) {
            return false;
        }

        Iterator<IASImportStatement> iterator = imports.iterator();
        String importValues = "";
        while (iterator.hasNext()) {
            IASImportStatement importStatement = iterator.next();
            String importValue = importStatement.getTargetString();
            importValues += "\"" + importValue + "\"" + ", ";
            String[] tokens = importValue.split("\\.");
            String lastToken = tokens[tokens.length - 1];
            if (importValue.equals(targetSuperClassPackageName + "." + givenSuperClassName)) {
                // case 1: import with qualifies class name like: import io.nucleo.inject.AConfig;
                return true;
            } else if (lastToken.equals("*")) {
                String wildCardPackageName = importValue.substring(0, importValue.length() - 2);
                if (wildCardPackageName.equals(targetSuperClassPackageName)) {
                    // case 2: import with wildcard like: import io.nucleo.inject.*;
                    return true;
                }
            }
        }
        // if not found in regular imports or wildcard imports it must be in the io.nucleo.inject package
        // case 3: no import needed because class is in the same package
        if (classPackageName.equals(targetSuperClassPackageName)) {
            return true;
        }

        // otherwise it is not the config class with our full qualified package name
        return false;
    }

    /**
     *
     * @param compilationUnits
     * @return
     */
    public static List<String> getMappingKeys(List<IASCompilationUnit> compilationUnits) {
        List<String> mappingKeys = new ArrayList<String>();
        for (Iterator<IASCompilationUnit> iterator = compilationUnits.iterator(); iterator.hasNext(); ) {
            IASCompilationUnit compilationUnit = iterator.next();
            IASClassType classType = (IASClassType) compilationUnit.getType();
            List<IASMethod> methods = classType.getMethods();
            for (Iterator<IASMethod> methodIterator = methods.iterator(); methodIterator.hasNext(); ) {
                IASMethod method = methodIterator.next();
                String methodText = method.toString();
                List<String> mappingKeysInMethod = getMappingKeysPerMethod(methodText);
                mappingKeys.addAll(mappingKeysInMethod);
            }
        }
        return mappingKeys;
    }

    /**
     *
     * @param methodText
     * @return
     */
    public static  List<String> getMappingKeysPerMethod(String methodText) {
        List<String> mappingKeys = new ArrayList<String>();
        Pattern pattern = Pattern.compile("(mapClass|mapInterface|mapParameterName){1}(\\(){1}(\")*(\\w*)(\")*(\\))");
        String methodTextWithoutComments = removeAllComments(methodText);
        Matcher matcher = pattern.matcher(methodTextWithoutComments);
        while (matcher.find()) {
            String result = matcher.group(4);
            mappingKeys.add(result);
        }
        return mappingKeys;
    }

    /**
     *
     * @param text
     * @return
     */
    public static String removeAllComments(String text) {
        text = removeBlockComments(text);
        text = removeLineComments(text);
        return text;
    }

    /**
     *
     * @param text
     * @return
     */
    public static String removeLineComments(String text) {
        Pattern pattern = Pattern.compile("(\\/\\/)(.*)(" + NL + ")?");
        Matcher matcher = pattern.matcher(text);
        String result = matcher.replaceAll("");
        return result;
    }

    /**
     *
     * @param text
     * @return
     */
    public static String removeBlockComments(String text) {
        Pattern pattern = Pattern.compile("/\\*([^*]|\" + NL + \"|(\\*+([^*/]|\" + NL + \")))*\\*+/");
        Matcher matcher = pattern.matcher(text);
        String result = matcher.replaceAll("");
        return result;
    }




}