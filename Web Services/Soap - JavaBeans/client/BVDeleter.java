import java.net.URL;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;
import org.apache.soap.Constants;
import org.apache.soap.Fault;
import org.apache.soap.SOAPException;

import org.apache.soap.encoding.SOAPMappingRegistry;
import org.apache.soap.encoding.soapenc.BeanSerializer;

import org.apache.soap.rpc.Call;
import org.apache.soap.rpc.Parameter;
import org.apache.soap.rpc.Response;

import org.apache.soap.util.xml.QName;

public class BVDeleter {

     public void deletelist(URL url, String model) throws SOAPException {

         SOAPMappingRegistry reg = new SOAPMappingRegistry();
         BeanSerializer serializer = new BeanSerializer();

         reg.mapTypes(Constants.NS_URI_SOAP_ENC,
              new QName("urn:VBean_xmlns","vObj"),
              VehicleBean.class, serializer, serializer);

         reg.mapTypes(Constants.NS_URI_SOAP_ENC,
              new QName("urn:VBean_xmlns","mObj"),
              MotorBean.class, serializer, serializer);

         Call call = new Call();

         call.setSOAPMappingRegistry(reg);
         call.setTargetObjectURI("urn:BVehicleCatalog");
         call.setMethodName("listV");
         call.setParams(null);

         Response response;
         response = call.invoke(url, "");

         Parameter returnValue = response.getReturnValue();

         Hashtable catalog = (Hashtable)returnValue.getValue();
         Enumeration e = catalog.keys();

//------------  D E L E T I N G ---------------------------------------------------
         System.out.println("Deleting vehicle model '" + model + "'" + "\n");

         VehicleBean vo = null;

         while (e.hasMoreElements()) {
               String VModel = (String)e.nextElement();
               if(VModel.equals(model)) {
                  vo = (VehicleBean)catalog.get(VModel);
                  break;
               }
         }

         call.setMethodName("delVehicleBean");
         call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);

         Vector params = new Vector();

         params.addElement(new Parameter("Obj", VehicleBean.class, vo, null));
         call.setParams(params);

         response = call.invoke(url, "");

         if (!response.generatedFault()) {
            System.out.println("Server reported NO FAULT while deleting vehicle\n");}
         else {
            Fault fault = response.getFault();
            System.out.println("Server reported FAULT while deleting:");
            System.out.println(fault.getFaultString());
         }

 //------------  L I S T I N G ---------------------------------------------------
          call.setMethodName("listV");
          call.setParams(null);

          response = call.invoke(url, "");

          returnValue = response.getReturnValue();

          catalog = (Hashtable)returnValue.getValue();
          e = catalog.keys();

          while (e.hasMoreElements()) {
                String VModel = (String)e.nextElement();
                vo = (VehicleBean)catalog.get(VModel);
                System.out.println(vo.toString());
          }
     }


     public static void main(String[] args) {
        if (args.length != 2) {
          System.out.println("Put url, model as arguments!!\n");
          return;
        }

        try {
               URL urlink = new URL(args[0]);
               String model = args[1];

               BVDeleter deleterlister = new BVDeleter();
               deleterlister.deletelist(urlink, model);
        }
        catch (Exception e) { e.printStackTrace(); }
     }
}
