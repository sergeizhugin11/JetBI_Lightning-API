public class Goods_Table_Controller {
    public class cGoods {
        public Goods__c con {get; set;}
        public Boolean selected {get; set;}
        public cGoods(Goods__c c) {
            con = c;
            selected = false;
        }
    }
    
    List<Goods__c> leads=new List<Goods__c>();
	public List<cGoods> results {get;set;}
    public String Name;
    public Decimal Price;
    public Integer Amount;
	public String Type;
    public Boolean Available;
    public Contact Data_01{get;set;}
    public Contact Data_02{get;set;} 
    public String Searcch;
    public Contact Searcch2{get;set;} 

    public Integer rec { get; set; }
    public Integer tot { get; set; }
    integer totalRecs = 0;
    integer count= 0;
    integer LimitSize= 50;   
    public boolean irr;
    
    public boolean getIrr() {
    	return this.irr;
    }
 
    public void setIrr(boolean irr) {
    	this.irr = true;
    }
    
    public boolean irr1;
    
    public boolean getIrr1() {
    	return this.irr1;
    }
 
    public void setIrr1(boolean irr1) {
    	this.irr1 = false;
    }
   
    
    public Goods_Table_Controller() {
        Data_01 = new Contact();
        Data_02 = new Contact();
        Searcch2 = new Contact();
        tot=totalRecs = [select count() from account];
	}

	integer i=0;
    public List<cGoods> getGoodsTable() {
        if(results == null) {
            results = new List<cGoods>();
            if(irr==false) {
                i=1;
                for(Goods__c c: [SELECT Name__c, Price__c, Amount__c, Type__c, Added_Date__c, Release_Date__c, Available__c FROM Goods__c 
                                 ORDER BY Name__c ASC NULLS last LIMIT:limitsize OFFSET:count]) {
                    results.add(new cGoods(c));
                }
            }
            if(irr==true) {
                i=1;
                for(Goods__c c: [SELECT Name__c, Price__c, Amount__c, Type__c, Added_Date__c, Release_Date__c, Available__c FROM Goods__c 
                                 ORDER BY Name__c DESC NULLS last LIMIT:limitsize OFFSET:count]) {
                    results.add(new cGoods(c));
                 }
            }
            if(i==0) {
                for(Goods__c c: [SELECT Name__c, Price__c, Amount__c, Type__c, Added_Date__c, Release_Date__c, Available__c FROM Goods__c 
                                 LIMIT:limitsize OFFSET:count]) {
                    results.add(new cGoods(c));
                 }
            }
        }
        return results;
    }
	public void updatePage() {
       	leads.clear();
		limitsize=rec;
       	leads=[SELECT Name__c, Price__c, Amount__c, Type__c, Added_Date__c, Release_Date__c, Available__c 
        	FROM Goods__c LIMIT:rec OFFSET:count];
        results = null;
	}
    public PageReference Firstbtn() {
    	count=0;
        results = null;
        return null;
    }
    public PageReference prvbtn() {
    	count=count-limitsize;
        results = null;
        return null;
    }
	public PageReference Nxtbtn() {
		count=count+limitsize;
        results = null;
        return null;
    }
    public PageReference lstbtn() {
		count= totalrecs - math.mod(totalRecs,LimitSize);
        results = null;
        return null;
    }
    public Boolean getNxt() {
        if((count + LimitSize) > totalRecs)
			return true;
    	else
       		return false;
    }
    public Boolean getPrv() {
    	if(count== 0)
        	return true;
        else
          	return false;
    }

    
    public String getName() {
    	return this.Name;
    }
 
    public void setName(String Name) {
    	this.Name = Name;
    }
    
    public Decimal getPrice() {
    	return this.Price;
    }
 
    public void setPrice(Decimal Price) {
    	this.Price = Price;
    }
    
    public Integer getAmount() {
    	return this.Amount;
    }
 
    public void setAmount(Integer Amount) {
    	this.Amount = Amount;
    }
    
    public String getType() {
    	return this.Type;
    }
 
    public void setType(String Type) {
    	this.Type = Type;
    }
    
    public Boolean getAvailable() {
    	return this.Available;
    }
 
    public void setAvailable(Boolean Available) {
    	this.Available = Available;
    }
    
    public String getSearcch() {
    	return this.Searcch;
    }
 
    public void setSearcch(String Searcch) {
    	this.Searcch = Searcch;
    }
    public List<SelectOption> getItems() {
    	List<SelectOption> op = new List<SelectOption>();
    	op.add(new SelectOption('Phones','Phones'));
        op.add(new SelectOption('Laptops','Laptops'));
        op.add(new SelectOption('Tablets','Tablets'));
    	return op;
    }
    
	public PageReference processSelected() {
		List<Goods__c> selectedGoods = new List<Goods__c>();
        for(cGoods cCon: getGoodsTable()) {
            if(cCon.selected == true) {
                selectedGoods.add(cCon.con); 
            }
        }
		delete selectedGoods;
        results = null;
        return null;
    }
    public boolean bolk;
    
    public boolean getBolk() {
    	return this.bolk;
    }
 
    public void setBolk(boolean bolk) {
    	this.bolk = false;
    }
    
    public boolean bolkDate;
    
    public boolean getBolkDate() {
    	return this.bolkDate;
    }
 
    public void setBolkDate(boolean bolkDate) {
    	this.bolkDate = false;
    }
    
    public boolean saveren;
    
    public boolean getSaveren() {
    	return this.saveren;
    }
 
    public void setSaveren(boolean saveren) {
    	this.saveren = false;
    }
    public PageReference Save() {
        bolkDate=false;
        bolk=false;
        saveren = false;
        if(Name.length()==0) {
            bolk=true;
            saveren = false;
            return null;
        }
       	if(Data_01.Birthdate<Date.Today()) {
            bolkDate=true;
            bolk=false;
            saveren = false;
            return null;
        }
        bolkDate=false;
        bolk=false;
        saveren = true;
        Goods__c new_item = new Goods__c();
        new_item.Name__c = this.Name;
        new_item.Price__c = this.Price;
        new_item.Amount__c = this.Amount;
        new_item.Type__c = this.Type;
        new_item.Added_Date__c = this.Data_01.Birthdate;
        new_item.Release_Date__c = this.Data_02.Birthdate;
        new_item.Available__c = this.Available;
		insert new_item;
        Name=null;
        Price = null;
        Amount = null;
        Type = null;
        Data_01.Birthdate = null;
        Data_02.Birthdate = null;
        Available = null;
        results = null;
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Add completed successfully'));
        return null;
    }
    
    public PageReference deleteVal() {
        bolkDate=false;
        bolk=false;
        saveren = false;
        Name=null;
        Price = null;
        Amount = null;
        Type = null;
        Data_01.Birthdate = null;
        Data_02.Birthdate = null;
        Available = null;
        return null;
    }
    public PageReference SearchByName() {
        
        results = new List<cGoods>();
        if(this.Searcch != null) {
            this.Searcch = '%' + this.Searcch + '%';
            for(Goods__c c: [SELECT Name__c, Price__c, Amount__c, Type__c, Added_Date__c, Release_Date__c, Available__c 
            FROM Goods__c WHERE Name__c LIKE : this.Searcch]) {
                results.add(new cGoods(c));
            }
        }
        else {
            for(Goods__c c: [SELECT Name__c, Price__c, Amount__c, Type__c, Added_Date__c, Release_Date__c, Available__c 
            FROM Goods__c]) {
                results.add(new cGoods(c));
            }
        }
        getGoodsTable();
        return null;
    }
    
    public PageReference SearchByDate() {
        
        results = new List<cGoods>();
        if(this.Searcch2 != null) {

            for(Goods__c c: [SELECT Name__c, Price__c, Amount__c, Type__c, Added_Date__c, Release_Date__c, Available__c 
            FROM Goods__c WHERE Added_Date__c = : this.Searcch2.Birthdate]) {
                results.add(new cGoods(c));
            }
        }
        else {
            for(Goods__c c: [SELECT Name__c, Price__c, Amount__c, Type__c, Added_Date__c, Release_Date__c, Available__c 
            FROM Goods__c]) {
                results.add(new cGoods(c));
            }
        }
        getGoodsTable();
        return null;
    }

    
    public PageReference Sort_01() {
        if(irr==false) {
        	irr = true;
        }
        else {
        	irr = false;
        }
        irr1 = !irr;
        results = null;
        getGoodsTable();

        return null;
    }
    /*public PageReference Sort_02() {
        

        return null;
    }*/
}