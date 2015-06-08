<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>FAQ APPROVAL</fullName>
        <active>false</active>
        <criteriaItems>
            <field>FAQ__kav.ArticleType</field>
            <operation>equals</operation>
            <value>Standard_How_To</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
