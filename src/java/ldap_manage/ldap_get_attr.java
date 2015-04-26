package ldap_manage;

/**
 * Created by IntelliJ IDEA.
 * User: paulaner
 * Date: 22.09.11
 * Time: 10:31
 * To change this template use File | Settings | File Templates.
 */
//import org.apache.tomcat.jni.Directory;

import java.io.IOException;
import java.util.Hashtable;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.ldap.LdapContext;

//import java.util.Hashtable;

//import javax.naming.Context;
import javax.naming.NamingEnumeration;
//import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
//import javax.naming.directory.DirContext;
//import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;


public class ldap_get_attr {


    @SuppressWarnings("unused")
	private DirContext connect(){
                       Hashtable<String, String> env = new Hashtable<String, String>();

                       env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");

                       env.put(Context.SECURITY_PRINCIPAL, "uid=tools,dc=intern,dc=paul-consultants,dc=de");  // SET USER
                       env.put(Context.SECURITY_CREDENTIALS, "i03U~4T~^VOo3b6J");  // SET PASSWORD HERE
                       env.put(Context.SECURITY_AUTHENTICATION, "simple");
                       env.put(Context.SECURITY_PROTOCOL, "clear");

                      /*
                       //THE LOCATION OF THE CACERTS MUST BE SPECIFIED
                       java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
                       System.setProperty("javax.net.ssl.keyStore",  "JAVAHOME\\lib\\security\\cacerts");
                       System.setProperty("javax.net.ssl.trustStore","JAVAHOME\\lib\\security\\cacerts");
                       */

                       env.put(LdapContext.CONTROL_FACTORIES, "com.sun.jndi.ldap.ControlFactory");

                       DirContext ctx;
                       try{
                            ctx = new InitialDirContext(env);
                       } catch(NamingException ne) {
    	                    System.err.println(ne);
    	                    ne.printStackTrace();
                           ctx = null;
    	               }
                       return ctx;
    }

    public static Integer main (String uid, String [] args) throws IOException  {

           Integer db2ID=0;
           try {

               Hashtable<String, String> env = new Hashtable<String, String>();

    	       env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
    	       env.put(Context.PROVIDER_URL, "ldap://intern.paul-consultants.de:389/");  // SET YOUR SERVER AND STARTING CONTEXT HERE
    	       env.put(Context.SECURITY_PRINCIPAL, "uid=tools,dc=intern,dc=paul-consultants,dc=de");  // SET USER
    	       env.put(Context.SECURITY_CREDENTIALS, "i03U~4T~^VOo3b6J");  // SET PASSWORD HERE
    	       env.put(Context.SECURITY_AUTHENTICATION, "simple");
    	       env.put(Context.SECURITY_PROTOCOL, "clear");

              /*
    	       //THE LOCATION OF THE CACERTS MUST BE SPECIFIED
    	       java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
    	       System.setProperty("javax.net.ssl.keyStore",  "JAVAHOME\\lib\\security\\cacerts");
    	       System.setProperty("javax.net.ssl.trustStore","JAVAHOME\\lib\\security\\cacerts");
               */

    	       env.put(LdapContext.CONTROL_FACTORIES, "com.sun.jndi.ldap.ControlFactory");


    	       DirContext ctx = new InitialDirContext(env);

                SearchControls sc = new SearchControls();
                String[] attrIDs = {"db2personid", "givenname", "sn"};
                sc.setReturningAttributes(attrIDs);

                // Specify the ids of the attributes to return
                String filter = "(uid="+uid+")";
                NamingEnumeration<?> results = ctx.search("dc=intern,dc=paul-consultants,dc=de", filter, sc);

                String s;

                while (results.hasMore() ) {
                        SearchResult sr = (SearchResult) results.next();
                        Attributes attrs = sr.getAttributes();
                        s = attrs.get("db2personid").toString();
                        db2ID = Integer.parseInt(s.substring(s.indexOf(":")+1).trim());
                        
                        
                }
                ctx.close();
                return  db2ID;
    	     }
    	     catch(NamingException ne) {
    	       System.err.println(ne);
    	       ne.printStackTrace();
    	     }
    return  db2ID;
    }
}
