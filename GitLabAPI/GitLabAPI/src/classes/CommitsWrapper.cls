public class CommitsWrapper {
	@AuraEnabled public String commitsName{get;set;}
	@AuraEnabled public String authorName{get;set;}
    @AuraEnabled public String addLines{get;set;}
    @AuraEnabled public String delLines{get;set;}
	@AuraEnabled public String createDate{get;set;}
}