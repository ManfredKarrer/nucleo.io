import io.nucleo.codegeneration.ant.DICodeGenerator;

public class AntRunner {

    ////////////////////////////////////////////////////////////////////////////////
    // This project use the as3-commons-jasblocks project which is based on antlr:
    // @see: https://github.com/teotigraphix/as3-commons-jasblocks
    // @see: http://www.antlr.org/
    ////////////////////////////////////////////////////////////////////////////////
    public static void main(String[] args) throws Exception {
        new DICodeGenerator();
    }
}
