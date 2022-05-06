# SAMCheckApp
This application is a Salesforce Lightning Web Component (LWC)

The HTML, JS, and JS-Meta file are the LWC. The CLS and CLS-Meta file are the Apex Class.

The purpose of this application is to live on a record page inside of Salesforce and allow internal users to request Entity Information from SAM.gov using their API. 

The Lighting Card has one input and one submit button. The input field will autofill from one of two fields that exist on the record. It will look to the SAM UEI first, if that is null, it will try the Cage Code field. 

When you click Submit, it queries SAM.gov by either the SAM Uei or Cage Code and returns back the Entity Information. 

This application will cut down the time it takes to search for their valid information by going directly to the source, and allowing internal personel the ease of access without having to log into SAM.gov. 

Credentials: these are saved within Salesforce under the Named Credentials section. You will notice in the samCall.cls file, that I and using a callout to this Named Credential that I have building out the URL with our API key and then appending the correct parameters at the end of the URL. 
