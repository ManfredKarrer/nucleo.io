package io.nucleo.codegeneration.ant;

import io.nucleo.codegeneration.di.ConstructorParameterBuilder;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

////////////////////////////////////////////////////////////////////////////////
// This project use the as3-commons-jasblocks project which is based on antlr:
// @see: https://github.com/teotigraphix/as3-commons-jasblocks
// @see: http://www.antlr.org/
////////////////////////////////////////////////////////////////////////////////
public class DICodeGenerator extends Task {

    private String sourcePaths;
    private String targetPath;

    @Override
    public void execute() throws BuildException {
        System.out.println("sourcePaths=" + sourcePaths);
        System.out.println("targetPath=" + targetPath);

        List<String> sourcePathList = new ArrayList<String>(Arrays.asList(sourcePaths.split(",")));
        for (Iterator<String> sourcePathsIterator = sourcePathList.iterator(); sourcePathsIterator.hasNext(); ) {
            String sourcePath = sourcePathsIterator.next();
            System.out.println("sourcePath=" + sourcePath);
        }

        ConstructorParameterBuilder constructorParameterBuilder = new ConstructorParameterBuilder(sourcePathList,
                                                                                                  targetPath);
        constructorParameterBuilder.build();
    }

    /**
     *
     * @param sourcePaths   Absolute source paths as comma separated list without space.
     */
    public void setSourcePaths(String sourcePaths) {
        this.sourcePaths = sourcePaths;
    }

    /**
     *
     * @param targetPath    Absolute path of target directory where the ConstructorParameters.as class
     *                      will be written to. The package structure will be generated automatically.
     */
    public void setTargetPath(String targetPath) {
        this.targetPath = targetPath;
    }

}