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

public class BVAdderLister {

     public void addlist(URL url, String model, String manufacturer, String year, String volume, String cylinders, String power)
         throws SOAPException{

         MotorBean mObj = new MotorBean(volume, cylinders, power);
         VehicleBean vObj = new VehicleBean(model, manufacturer, year, mObj);

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
         call.setMethodName("addV");
         call.setEncodingStyleURI(Constants.NS_URI_SOAP_ENC);

//------------  A D D I N G ---------------------------------------------------
         System.out.println("Adding vehicle model '" + model + "' by " + manufacturer + "\n");

         Vector params = new Vector();

         params.addElement(new Parameter("vObj", VehicleBean.class, vObj, null));
         call.setParams(params);

         Response response;
         response = call.invoke(url, "");

         if (!response.generatedFault()) {
            System.out.println("Server reported NO FAULT while adding vehicle\n");}
         else {
            Fault fault = response.getFault();
            System.out.println("Server reported FAULT while adding:");
            System.out.println(fault.getFaultString());
         }

 //------------  L I S T I N G ---------------------------------------------------
          call.setMethodName("listV");
          call.setParams(null);

          response = call.invoke(url, "");

          Parameter returnValue = response.getReturnValue();

          Hashtable catalog = (Hashtable)returnValue.getValue();
          Enumeration e = catalog.keys();

          while (e.hasMoreElements()) {
                String VModel = (String)e.nextElement();
                VehicleBean vo = (VehicleBean)catalog.get(VModel);
                System.out.println(vo.toString());
          }
     }


     public static void main(String[] args) {
        if (args.length != 7) {
          System.out.println("Put url, model, manufacturer, year, volume, cylinders and power as arguments!!\n");
          return;
        }

        try {
               URL urlink = new URL(args[0]);
               String model = args[1];
               String manufacturer = args[2];
               String year = args[3];
               String volume = args[4];
               String cylinders = args[5];
               String power = args[6];

               BVAdderLister adderlister = new BVAdderLister();
               adderlister.addlist(urlink, model, manufacturer, year, volume, cylinders, power);
        }
        catch (Exception e) { e.printStackTrace(); }
     }
}
