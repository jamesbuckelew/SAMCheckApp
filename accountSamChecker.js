import { LightningElement,wire,track,api } from 'lwc';

    import getDuns from '@salesforce/apex/samCall.samQuery';
    import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
    import samUEI from '@salesforce/schema/Account.SAM_UEI__c';
    import cageCode from '@salesforce/schema/Account.CAGE__c';

    const FIELDS = [
        samUEI,
        cageCode
        ];
 
    export default class searchSam extends LightningElement {
    @api recordId;
    @api inputNumber;
    @api inputType;
    @api output;
    @track samRecord;
    @track error;
    @track data;
    @track naicsArray;
    @track pscArray;

    @wire(getRecord, {recordId: '$recordId',fields: FIELDS})
    record;

    get idSAM() {
        var ueiVal = getFieldValue(this.record.data, samUEI);
        var cageVal = getFieldValue(this.record.data, cageCode);
        if (ueiVal) {
            return ueiVal;
        } else {
            return cageVal;
        }
    }

        handleClick(event){

            let inputDuns = this.template.querySelector('lightning-input').value;

            this.inputNumber = inputDuns;

            var inputType;

            if (this.inputNumber.length == 9){
                console.log("Yeah, dis a Duns.");
                inputType = "You typed in a DUNS but SAM doesn't use this any more.";
            } else if (this.inputNumber.length == 12){
                console.log("It's UEI for sure.");
                inputType = "ueiSAM=";
            } else if (this.inputNumber.length == 5){
                console.log("Thanks for the Cage Code!");
                inputType = "cageCode=";
            } else if (this.inputNumber.length != 12 || this.inputNumber.length != 9 || this.inputNumber.length != 5) {
                console.log("Sheesh, what did you type in?");
                inputType = "Invalid Input: ";
            }

            this.output = inputType + this.inputNumber;
            console.log(this.output);

        }

        @wire(getDuns,{ accountUei: '$output'})
        
        samData({ error, data }) {

            if (data) {

                //Parse String to JSON here so that I can call each key from the HTML
                this.samRecord = JSON.parse(data);
                
                //Need to iterate over the index, i++ instead of hardcoding that index point. 

                const naicsArray = this.samRecord.naicsList;
                const pscArray = this.samRecord.pscList;

                var naicsCodes = [];
                for (let i = 0; i < naicsArray.length; i++) {
                    let obj = {
                        id: i,
                        val: naicsArray[i].naicsCode + " - " + naicsArray[i].naicsDescription
                    };
                    naicsCodes.push(obj);
                }

                var pscCodes = [];
                for (let i = 0; i < pscArray.length; i++) {
                    let objP = {
                        id: i,
                        val: pscArray[i].pscCode + " - " + pscArray[i].pscDescription
                    };
                    pscCodes.push(objP);
                }

                this.naics = naics;
                this.psc = pscCodes;

                console.log(this.naics);
                console.log(this.psc);
            
                this.error = undefined;

            } else if (error) {

                //console.log('Error block');
                this.error = error;

                this.samRecord = undefined;

            }

        }

 }
