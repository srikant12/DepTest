public class CaseFSDynamicController 
{
Case casev;
    
public Case getCase() 
{
        if (casev == null) casev = new Case();
        return casev;
}
 
public void setCase(Case c) 
{
    casev = c;        
}

    
public void Save()
{
        insert casev;
}

}