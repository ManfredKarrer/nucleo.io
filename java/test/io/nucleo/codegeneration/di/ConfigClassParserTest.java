package io.nucleo.codegeneration.di;

import org.as3commons.asblocks.dom.IASImportStatement;
import org.as3commons.asblocks.impl.MockASTASImportStatement;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import static org.junit.Assert.*;

public class ConfigClassParserTest {

    // new line
    public static final String NL = System.getProperty("line.separator");


    @Test
    public void test_isExtendingSuperClass() throws Exception {
        List<IASImportStatement> imports;
        String packageName;
        String superClassName;
        String targetSuperClassName;
        String targetSuperClassPackageName;
        boolean result;

        // regular import
        String[] targetStrings1 = {"org.dummy.project.IModel",
                "org.dummy.project.formatter.IFormatter",
                "io.nucleo.inject.AConfig"};
        imports = getMockImports(targetStrings1);
        packageName = "org.dummy.project.factory";
        superClassName = "AConfig";
        targetSuperClassName = "AConfig";
        targetSuperClassPackageName = "io.nucleo.inject";
        result = ConfigClassParser.isExtendingSuperClass(imports,
                                                         packageName,
                                                         superClassName,
                                                         targetSuperClassName,
                                                         targetSuperClassPackageName);
        assertTrue(result);

        // wildcard import
        String[] targetStrings2 = {"org.dummy.project.IModel",
                "org.dummy.project.formatter.IFormatter",
                "io.nucleo.inject.*"};
        imports = getMockImports(targetStrings2);
        packageName = "org.dummy.project.factory";
        superClassName = "AConfig";
        targetSuperClassName = "AConfig";
        targetSuperClassPackageName = "io.nucleo.inject";
        result = ConfigClassParser.isExtendingSuperClass(imports,
                                                         packageName,
                                                         superClassName,
                                                         targetSuperClassName,
                                                         targetSuperClassPackageName);
        assertTrue(result);

        // no import because same package
        String[] targetStrings3 = {"org.dummy.project.IModel",
                "org.dummy.project.formatter.IFormatter"};
        imports = getMockImports(targetStrings3);
        packageName = "io.nucleo.inject";
        superClassName = "AConfig";
        targetSuperClassName = "AConfig";
        targetSuperClassPackageName = "io.nucleo.inject";
        result = ConfigClassParser.isExtendingSuperClass(imports,
                                                         packageName,
                                                         superClassName,
                                                         targetSuperClassName,
                                                         targetSuperClassPackageName);
        assertTrue(result);

        // no superclass
        String[] targetStrings4 = {"org.dummy.project.IModel",
                "org.dummy.project.formatter.IFormatter",
                "io.nucleo.inject.AConfig"};
        imports = getMockImports(targetStrings4);
        packageName = "org.dummy.project.factory";
        superClassName = null;
        targetSuperClassName = "AConfig";
        targetSuperClassPackageName = "io.nucleo.inject";
        result = ConfigClassParser.isExtendingSuperClass(imports,
                                                         packageName,
                                                         superClassName,
                                                         targetSuperClassName,
                                                         targetSuperClassPackageName);
        assertFalse(result);

        // superclass is no config
        String[] targetStrings5 = {"org.dummy.project.IModel",
                "org.dummy.project.formatter.IFormatter",
                "io.nucleo.inject.AConfig"};
        imports = getMockImports(targetStrings5);
        packageName = "org.dummy.project.factory";
        superClassName = "AFactory";
        targetSuperClassName = "AConfig";
        targetSuperClassPackageName = "io.nucleo.inject";
        result = ConfigClassParser.isExtendingSuperClass(imports,
                                                         packageName,
                                                         superClassName,
                                                         targetSuperClassName,
                                                         targetSuperClassPackageName);
        assertFalse(result);

        // superclass is AConfig but other package
        String[] targetStrings6 = {"org.dummy.project.IModel",
                "org.dummy.project.formatter.IFormatter",
                "org.dummy.other.AConfig"};
        imports = getMockImports(targetStrings6);
        packageName = "org.dummy.project.factory";
        superClassName = "AConfig";
        targetSuperClassName = "AConfig";
        targetSuperClassPackageName = "io.nucleo.inject";
        result = ConfigClassParser.isExtendingSuperClass(imports,
                                                         packageName,
                                                         superClassName,
                                                         targetSuperClassName,
                                                         targetSuperClassPackageName);
        assertFalse(result);
    }


    private List<IASImportStatement> getMockImports(String[] targetStrings) {
        List<IASImportStatement> imports = new ArrayList<IASImportStatement>();
        for (String targetString : targetStrings) {
            IASImportStatement importStatement = new MockASTASImportStatement(targetString);
            imports.add(importStatement);
        }
        return imports;
    }


    @Test
    public void test_getMappingKeysPerMethod() throws Exception {
        String methodText;
        List<String> result;
        List<String> expected;
        Iterator<String> expectedIterator;

        methodText = "override protected function setup():void {\n" +
                "}";
        expected = new ArrayList<String>();
        expectedIterator = expected.iterator();
        checkResult(methodText, expectedIterator);

        methodText = "override protected function setup():void {\n" +
                "mapParameterName(\"bundleName\").toInstance(\"MOD_calendarfactsheet\");\n" +
                "}";
        expected = new ArrayList<String>();
        expected.add("bundleName");
        expectedIterator = expected.iterator();
        checkResult(methodText, expectedIterator);

        methodText = "override protected function setup():void {\n" +
                "mapParameterName(\"bundleName\").toInstance(\"MOD_calendarfactsheet\");\n" +
                "mapClass(ModuleDataTransformer).toClass(ModuleDataTransformer).asSingleton();\n" +
                "mapClass(HeaderPresentation).toClass(HeaderPresentation).asSingleton();\n" +
                "mapClass(BackgroundPresentation).toClass(BackgroundPresentation).asSingleton();\n" +
                "mapClass(MainPresentation).toClass(MainPresentation).asSingleton();\n" +
                "}";
        expected = new ArrayList<String>();
        expected.add("bundleName");
        expected.add("ModuleDataTransformer");
        expected.add("HeaderPresentation");
        expected.add("BackgroundPresentation");
        expected.add("MainPresentation");
        expectedIterator = expected.iterator();
        checkResult(methodText, expectedIterator);
    }
    private void checkResult(String methodText, Iterator<String> expectedIterator) {
        List<String> result;
        result = ConfigClassParser.getMappingKeysPerMethod(methodText);
        for (Iterator<String> iterator = result.iterator(); iterator.hasNext(); ) {
            String key = iterator.next();
            String expectedKey = expectedIterator.next();
            assertEquals(expectedKey, key);
        }
    }

    @Test
    public void test_removeLineComments() throws Exception {
        String inputText;
        String expected;
        String strResult;

        inputText = "";
        expected = "";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "//";
        expected = "";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = " //";
        expected = " ";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "aa//";
        expected = "aa";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "//" + NL;
        expected = "";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "//" + NL + "aa";
        expected = "aa";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "//" + NL + NL;
        expected = NL;
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "//" + NL + "//" + NL;
        expected = "";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "// aaa" + NL + "//aa" + NL;
        expected = "";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "aaa" + NL + "//aa" + NL + "aa" + NL;
        expected = "aaa" + NL + "aa" + NL;
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);


        inputText = "//aaaa";
        expected = "";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "//   aaaa";
        expected = "";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "aa";
        expected = "aa";
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);

        inputText = "aa" + NL + NL;
        expected = "aa" + NL + NL;
        strResult = ConfigClassParser.removeLineComments(inputText);
        assertEquals(expected, strResult);
    }

    @Test
    public void test_removeBlockComments() throws Exception {
        String inputText;
        String expected;
        String strResult;

        inputText = "";
        expected = "";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "/**/";
        expected = "";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = " /**/";
        expected = " ";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = " /**/a";
        expected = " a";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "aa/**/";
        expected = "aa";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "/**/aa";
        expected = "aa";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "/**/" + NL;
        expected = NL;
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "/**/" + NL + "aa";
        expected = NL + "aa";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "/**/" + NL + NL;
        expected = NL + NL;
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "/**/" + NL + "/**/" + NL;
        expected = NL + NL;
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "/* aaa*/" + NL + "/*aa*/" + NL;
        expected = NL + NL;
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "aaa" + NL + "/*aa*/" + NL + "aa" + NL;
        expected = "aaa" + NL + NL + "aa" + NL;
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);


        inputText = "/*aaaa*/";
        expected = "";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "/*   aaaa*/";
        expected = "";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "aa";
        expected = "aa";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "aa" + NL + NL;
        expected = "aa" + NL + NL;
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "a/*b" + NL + "*/" + "c";
        expected = "ac";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);

        inputText = "a/*b*/" + "c";
        expected = "ac";
        strResult = ConfigClassParser.removeBlockComments(inputText);
        assertEquals(expected, strResult);
    }

    @Test
    public void test_removeAllComments() throws Exception {
         String inputText;
        String expected;
        String strResult;

        inputText = "/**///";
        expected = "";
        strResult = ConfigClassParser.removeAllComments(inputText);
        assertEquals(expected, strResult);

        inputText = " /**/ // ";
        expected = "  ";
        strResult = ConfigClassParser.removeAllComments(inputText);
        assertEquals(expected, strResult);

        inputText = " /**/a //";
        expected = " a ";
        strResult = ConfigClassParser.removeAllComments(inputText);
        assertEquals(expected, strResult);

        inputText = "aa/**/ //";
        expected = "aa ";
        strResult = ConfigClassParser.removeAllComments(inputText);
        assertEquals(expected, strResult);

        inputText = "/**/aa //";
        expected = "aa ";
        strResult = ConfigClassParser.removeAllComments(inputText);
        assertEquals(expected, strResult);

        inputText = "///**/" + NL;
        expected = "";
        strResult = ConfigClassParser.removeAllComments(inputText);
        assertEquals(expected, strResult);

        inputText = "///**/" + NL + "aa";
        expected = "aa";
        strResult = ConfigClassParser.removeAllComments(inputText);
        assertEquals(expected, strResult);

        inputText = "///**/" + NL + NL;
        expected = NL;
        strResult = ConfigClassParser.removeAllComments(inputText);
        assertEquals(expected, strResult);
    }


}
