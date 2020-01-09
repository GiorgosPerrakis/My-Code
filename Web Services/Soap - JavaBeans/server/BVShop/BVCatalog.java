package BVShop;

import java.util.Hashtable;

public class BVCatalog {

     private Hashtable catalog;

     public BVCatalog() {
         catalog = new Hashtable();

         addV(new VehicleBean("Buick","General Motors","1948", new MotorBean("1500", "3", "100")));
         addV(new VehicleBean("Mustang","Ford","1960", new MotorBean("1800", "4", "230")) );
         addV(new VehicleBean("4CV","Citroen","1950", new MotorBean("2000", "4", "360")));
         addV(new VehicleBean("Jeep","General Motors", "1942", new MotorBean("1500", "2", "80")));
         addV(new VehicleBean("Beatle","Volkswagen","1938", new MotorBean("1700", "3", "156")));
     }

     public void addV(VehicleBean vObj) {
         if (vObj == null) {
              throw new IllegalArgumentException("The object provided cannot be null");
         }
         catalog.put(vObj.getVModel(), vObj);
         System.out.println("Addition at server side: " + vObj.getVModel());
    }

     public Hashtable listV() { return catalog; }

     public void delVehicleBean(VehicleBean vObj) {
       if (vObj == null) {
            throw new IllegalArgumentException("This car doesn't exist");
       }
       System.out.println("Delete from server: " + vObj.getVModel());
       catalog.remove(vObj.getVModel());
     }
}
