public class StatisticsWrapper implements Comparable {
	@AuraEnabled public String projectId{get;set;}
    @AuraEnabled public String nameOfProject{get;set;}
    @AuraEnabled public String commits{get;set;}
	@AuraEnabled public String bestCommiter{get;set;}
	public Integer compareTo(Object compareTo) {
        StatisticsWrapper compareToEmp = (StatisticsWrapper)compareTo;
        if (Integer.valueOf(commits) == Integer.valueOf(compareToEmp.commits)) return 0;
        if (Integer.valueOf(commits) > Integer.valueOf(compareToEmp.commits)) return 1;
        return -1;
    }
}