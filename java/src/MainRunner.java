import io.nucleo.codegeneration.ant.DICodeGenerator;

import java.util.ArrayList;
import java.util.List;

public class MainRunner {

    ////////////////////////////////////////////////////////////////////////////////
    // This project use the as3-commons-jasblocks project which is based on antlr:
    // @see: https://github.com/teotigraphix/as3-commons-jasblocks
    // @see: http://www.antlr.org/
    ////////////////////////////////////////////////////////////////////////////////
    public static void main(String[] args) throws Exception {
        String targetPath = "your path to the generated src dir";
        List<String> sourcePaths = new ArrayList<String>();
        String sourcePath = "your path to the src dir";
        DICodeGenerator codeGenerator = new DICodeGenerator();
        codeGenerator.setTargetPath(targetPath);
        codeGenerator.setSourcePaths(sourcePath);
        codeGenerator.execute();
    }
}
