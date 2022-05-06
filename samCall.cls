public class samCall {

    @AuraEnabled(cacheable=true)
    public static string samQuery(string accountUei) {
    
        HttpRequest req = new HttpRequest();
        req.setEndpoint( 'callout:samAPI/entity-information/v3/entities?' + accountUei);
        req.setHeader( 'X-Api-Key', '{!$Credential.Password}' );
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
    
        entityApi parsedResponse =  (entityApi) JSON.deserialize(res.getBody(), entityApi.class);

        Object entReg = parsedResponse.entityData[0].entityRegistration;
        Object entCode = parsedResponse.entityData[0].assertions.goodsAndServices.primaryNaics;
        Object entNACode = parsedResponse.entityData[0].assertions.goodsAndServices.naicsList;
        Object entPscCode = parsedResponse.entityData[0].assertions.goodsAndServices.pscList;
        Object entAdd = parsedResponse.entityData[0].coreData.physicalAddress;
        Object entMail = parsedResponse.entityData[0].coreData.mailingAddress;

        String pretty = JSON.serialize(entReg);
        String pretty2 = JSON.serialize(entCode);
        String pretty3 = JSON.serialize(entAdd);
        String pretty4 = JSON.serialize(entNACode);
        String pretty5 = JSON.serialize(entPscCode);
        String pretty6 = JSON.serialize(entMail);

        pretty = pretty.removeEnd('}');

        pretty = pretty+',"primaryNaics":'+pretty2+',"physicalAddress":'+pretty3+',"mailingAddress":'+pretty6+',"naicsList":'+pretty4+',"pscList":'+pretty5+'}';

        System.debug('Is this pretty? >>>' + ' ' + pretty);

        return pretty;

    }


    public class entityApi {

        public Integer totalRecords;
        public List<EntityData> entityData;
        public List<NaicsList> naicsList;
    }
    
        public class FinancialInformation {
            public String creditCardUsage;
            public String debtSubjectToOffset;
        }
    
        public class NaicsList {
            public String naicsCode;
            public String naicsDescription;
            public String sbaSmallBusiness;
        }
    
        public class EntityData {
            public EntityRegistration entityRegistration;
            public CoreData coreData;
            public Assertions assertions;
            public PointsOfContact pointsOfContact;
        }
    
        public class PhysicalAddress {
            public String addressLine1;
            public String city;
            public String stateOrProvinceCode;
            public String zipCode;
            public String zipCodePlus4;
            public String countryCode;
        }
    
        public class Assertions {
            public GoodsAndServices goodsAndServices;
            public DisasterReliefData disasterReliefData;
            public EdiInformation ediInformation;
        }
    
        public class GovernmentBusinessAlternatePOC {
            public String firstName;
            public String middleInitial;
            public String lastName;
            public String title;
            public String addressLine1;
            public String addressLine2;
            public String city;
            public String stateOrProvinceCode;
            public String zipCode;
            public String zipCodePlus4;
            public String countryCode;
        }
    
        public class EdiInformation {
            public String ediInformationFlag;
        }
    
        public class DisasterReliefData {
            public String disasterRegistryFlag;
            public String bondingFlag;
            public List<GeographicalAreaServed> geographicalAreaServed;
        }
    
        public class CoreData {
            public EntityInformation entityInformation;
            public PhysicalAddress physicalAddress;
            public PhysicalAddress mailingAddress;
            public String congressionalDistrict;
            public GeneralInformation generalInformation;
            public FinancialInformation financialInformation;
        }
    
        public class PointsOfContact {
            public GovernmentBusinessPOC governmentBusinessPOC;
            public GovernmentBusinessPOC electronicBusinessPOC;
            public GovernmentBusinessAlternatePOC governmentBusinessAlternatePOC;
            public GovernmentBusinessAlternatePOC electronicBusinessAlternatePOC;
            public GovernmentBusinessAlternatePOC pastPerformancePOC;
            public GovernmentBusinessAlternatePOC pastPerformanceAlternatePOC;
        }
    
        public class GeneralInformation {
            public String entityStructureCode;
            public String entityStructureDesc;
            public String entityTypeCode;
            public String entityTypeDesc;
            public String profitStructureCode;
            public String profitStructureDesc;
            public String organizationStructureCode;
            public String stateOfIncorporationCode;
            public String stateOfIncorporationDesc;
            public String countryOfIncorporationCode;
            public String countryOfIncorporationDesc;
        }
    
        public class GoodsAndServices {
            public String primaryNaics;
            public List<NaicsList> naicsList;
            public List<PscList> pscList;
        }
    
        public class GovernmentBusinessPOC {
            public String firstName;
            public String middleInitial;
            public String lastName;
            public String title;
            public String addressLine1;
            public String addressLine2;
            public String city;
            public String stateOrProvinceCode;
            public String zipCode;
            public String zipCodePlus4;
            public String countryCode;
        }
    
        public class EntityInformation {
            public String entityURL;
            public String entityDivisionName;
            public String entityDivisionNumber;
            public String entityStartDate;
            public String fiscalYearEndCloseDate;
            public String submissionDate;
        }
    
        public class PscList {
            public String pscCode;
            public String pscDescription;
        }
    
        public class Links {
            public String selfLink;
        }
    
        public class GeographicalAreaServed {
            public String geographicalAreaServedStateCode;
            public String geographicalAreaServedStateName;
            public String geographicalAreaServedCountyCode;
            public String geographicalAreaServedCountyName;
            public String geographicalAreaServedmetropolitanStatisticalAreaCode;
            public String geographicalAreaServedmetropolitanStatisticalAreaName;
        }
    
        public class EntityRegistration {
            public String samRegistered;
            public String ueiSAM;
            public String ueiDUNS;
            public String entityEFTIndicator;
            public String cageCode;
            public String dodaac;
            public String legalBusinessName;
            public String dbaName;
            public String purposeOfRegistrationCode;
            public String purposeOfRegistrationDesc;
            public String registrationStatus;
            public String registrationDate;
            public String lastUpdateDate;
            public String registrationExpirationDate;
            public String activationDate;
            public String ueiStatus;
            public String ueiExpirationDate;
            public String ueiCreationDate;
            public String noPublicDisplayFlag;
            public String exclusionStatusFlag;
            public String exclusionURL;
            public String dnbOpenData;
        }
    }
