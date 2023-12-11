public class StringIndex {
                public List<Integer> findIndex(String str,String character){                         
                    List<Integer> indexofString = new List<Integer>();
                    String [] arrayofString = str.split('');       
                    for (Integer i = 0; i< arrayofString.size(); i++) {		          
                        if(arrayofString[i]==character){  
                            
                            indexofString.add(i);
                            
                        }
                               
                    }
                    system.debug('index of string--->'+indexofString);
                    return indexofString;
                }  
                public Integer findNumberofoccurence_Character(String str,String character){     
                    Integer count = 0;
                    String [] arrayofString = str.split('');
                    for (Integer i = 0; i< arrayofString.size(); i++) {
                        if(arrayofString[i]==character){  
                            //system.debug('i--->'+i);
                            count++;                
                        }
                            
                    }
                    system.debug('Count of '+character+ '--->'+count);
                    return count;       
                }   
                public Map<String,Integer> findNumberofoccurence_EachCharacter(String str){
                    
                    Map<String,Integer> totalNumberofOccurance = new Map<String,Integer>();
                    String [] arrayofString = str.split('');
                    
                    for (Integer i = 0; i< arrayofString.size(); i++) {
                        Integer count = 0;
                        
                        for(String compCharacter:arrayofString){                           
                            if(arrayofString[i]==compCharacter){  
                                //system.debug('i--->'+i);
                                count++;                
                            }
                            
                        }
                        totalNumberofOccurance.put(arrayofString[i],count);
                           
                        
                    }
                    system.debug('Count--->'+totalNumberofOccurance); 
                    return totalNumberofOccurance;
                }
                
            }