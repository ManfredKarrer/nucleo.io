package org.as3commons.asblocks.impl;

import org.as3commons.asblocks.dom.ASQName;
import org.as3commons.asblocks.dom.IASExpression;
import org.as3commons.asblocks.dom.IASImportStatement;

public class MockASTASImportStatement implements IASImportStatement {

    private String targetString;

    public MockASTASImportStatement(String targetString) {
        this.targetString = targetString;
    }

    @Override
    public IASExpression getTarget() {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public void setTarget(IASExpression value) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public void parseTarget(String value) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public String getTargetString() {
        return targetString;
    }

    @Override
    public ASQName getQName() {
        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
