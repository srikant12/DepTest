<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Mailing_city_chnaged</fullName>
        <description>Mailing city chnaged</description>
        <protected>false</protected>
        <recipients>
            <recipient>rsrikant@salesforce.com.badge</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>InternalNotifications/LeadsNewassignmentnotificationSAMPLE</template>
    </alerts>
    <rules>
        <fullName>email alert</fullName>
        <actions>
            <name>Mailing_city_chnaged</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>MailingCity &lt;&gt; PRIORVALUE(MailingCity)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
