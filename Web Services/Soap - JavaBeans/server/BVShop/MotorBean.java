package BVShop;

public class MotorBean {
     String MCc;
     String MNo_cylinders;
     String MPs;

     public MotorBean() {}

     public MotorBean(String volume, String cylinders, String power) {
       this.MCc = volume;
       this.MNo_cylinders = cylinders;
       this.MPs = power;
    }

      public String getMCc(){ return MCc; }
      public void setMCc(String volume) { this.MCc = volume; }
      public String getMNo_cylinders() { return MNo_cylinders; }
      public void setMNo_cylinders(String cylinders) { this.MNo_cylinders = cylinders; }
      public String getMPs() { return MPs; }
      public void setMPs(String power) { this.MPs = power; }

      public String toString() {
         return MCc + " " + MNo_cylinders + " " + MPs;
      }
}
