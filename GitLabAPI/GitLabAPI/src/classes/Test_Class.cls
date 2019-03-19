@isTest
public class Test_Class {
    public static testMethod void testMyController_01() {
    	Goods__c test = new Goods__c( 
            Name__c = 'Samsung Galaxy S7', 
            Price__c = 850,
            Amount__c = 800,
            Type__c = 'Phones',
            Added_Date__c = Date.Today(),
            Release_Date__c = Date.Today().addDays(5), 
            Available__c = true                          
        );
        insert test;

        Goods_Table_Controller controller = new Goods_Table_Controller();
 		controller.Name='Xiomi 4x';
        controller.Price = 300;
      	controller.Amount = 200;
       	controller.Type = 'Phones';
        controller.Available = true;
        controller.Searcch = 'Samsung Galaxy S7';
        controller.Searcch2.Birthdate = Date.today();
        controller.rec = 10;
        controller.tot = 100;
        controller.Save();

        Goods__c leads = [SELECT Price__c FROM Goods__c where Name__c ='Xiomi 4x']; 
        System.assertEquals(300, leads.Price__C);
       
        
        controller.getName();
        controller.getPrice();
        controller.getAmount();
        controller.getType();
        controller.getAvailable();
        controller.getSearcch();
       	controller.getIrr();
        controller.getIrr1();
        controller.getBolk();
        controller.getBolkDate();
        controller.getSaveren();
        controller.setName('Samsung');
        controller.setPrice(900);
        controller.setAmount(150);
        controller.setType('Phones');
        controller.setAvailable(true);
        controller.setSearcch('Samsumg');
        controller.setIrr(true);
        controller.setIrr1(true);
        controller.setBolk(true);
        controller.setBolkDate(true);
        controller.setSaveren(true);
        
        System.assertEquals(null, controller.Firstbtn());
        System.assertEquals(null, controller.prvbtn());
        System.assertEquals(null, controller.Nxtbtn());
        System.assertEquals(null, controller.lstbtn());
        System.assertEquals(null, controller.deleteVal());
        
        
        System.assertEquals(true, controller.getNxt());
        System.assertEquals(true, controller.getPrv());
        
        
        System.assertEquals(null, controller.SearchByName());
        System.assertEquals(null, controller.SearchByDate());
        System.assertEquals(1, controller.getGoodsTable().size());
        System.assertEquals(3, controller.getItems().size());
 		System.assertEquals(null, controller.Sort_01());
        System.assertEquals(null, controller.processSelected());
       
        controller.updatePage();
    }

}