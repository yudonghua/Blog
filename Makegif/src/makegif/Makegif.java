package makegif;

import java.awt.AWTException;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.MouseInfo;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.imageio.ImageIO;


public class Makegif {
    static BufferedImage bufferedImage[];
 
 public static void main(String[] args) throws AWTException, IOException, InterruptedException {
     Point p= MouseInfo.getPointerInfo().getLocation();
     System.out.print(p.x+":"+p.y);
  cut();
  jpgToGif();
 }
 public static void jpgToGif(){
     AnimatedGifEncoder e = new AnimatedGifEncoder();
        e.setRepeat(0);
        e.start("e:/laoma.gif");
        for (int i = 0;i<100;i++){
            e.setDelay(20); 
            e.addFrame(bufferedImage[i]);
        }
        e.finish(); 
    }
    public static void cut() throws AWTException, IOException, InterruptedException{
           Dimension d = Toolkit.getDefaultToolkit().getScreenSize(); 
           Robot robot = new Robot(); 
           
           bufferedImage = new BufferedImage[100];
           
           for (int i = 0;i<100;i++){
               Thread.sleep(20);
               bufferedImage[i] = robot.createScreenCapture(new Rectangle(0,0,100,100)); 
              // d.width,d.height
           }
   }
}



