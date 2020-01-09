
public class VehicleBean {
     String VModel;
     String VManufacturer;
     String VYear;
     MotorBean VMotor;

     public VehicleBean() {}

     public VehicleBean(String model, String manu, String year, MotorBean motor) {
       this.VModel = model;
       this.VManufacturer = manu;
       this.VYear = year;
       this.VMotor = motor;
     }

     public String getVModel() { return VModel; }
     public void setVModel(String model) { this.VModel = model; }
     public String getVManufacturer() { return VManufacturer; }
     public void setVManufacturer(String manu) { this.VManufacturer = manu; }
     public String getVYear() { return VYear; }
     public void setVYear(String year) { this.VYear = year; }
     public MotorBean getVMotor() { return VMotor; }
     public void setVMotor(MotorBean motor) { this.VMotor = motor; }

     public String toString() {
      	return "'" + VModel + "' by " + VManufacturer + " " + VYear + " " + getVMotor().toString();
    }
}
