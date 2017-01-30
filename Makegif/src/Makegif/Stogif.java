/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package stogif;

import java.awt.AWTEvent;
import java.awt.AWTException;
import java.awt.Color;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.MouseInfo;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.Window;
import java.awt.event.AWTEventListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowFocusListener;
import java.awt.event.WindowListener;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

/**
 *
 * @author PC
 */
public class Stogif extends JFrame{
    static JTextField x1,x2,y1,y2;
    static BufferedImage bufferedImage[];

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws AWTException {
   //     Toolkit.getDefaultToolkit().addAWTEventListener(new Listener(), AWTEvent.MOUSE_EVENT_MASK | AWTEvent.FOCUS_EVENT_MASK);
//        Robot robot = new Robot();
//        robot.mouseMove(500, 500);
        Toolkit.getDefaultToolkit().addAWTEventListener(new AWTEventListener() {
			
		@Override
		public void eventDispatched(AWTEvent event) {
				// TODO Auto-generated method stub
                    if(((KeyEvent)event).getID()==KeyEvent.KEY_PRESSED&&((KeyEvent)event).getKeyCode()==KeyEvent.VK_F1){
                        Point point = MouseInfo.getPointerInfo().getLocation();
                        x1.setText(x2.getText());
                        y1.setText(y2.getText());
                        x2.setText(point.x+"");
                        y2.setText(point.y+"");
                    }
			
		}

           
        }, AWTEvent.KEY_EVENT_MASK);
        Stogif frame = new Stogif(); 
        frame.setTitle("屏幕录制");
        frame.setSize(400, 300);
        frame.setLocationRelativeTo(null);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
                

    }
    public static void cut(int p_x,int p_y,int p_x2,int p_y2,String path,int num) throws AWTException, IOException, InterruptedException{
           Dimension d = Toolkit.getDefaultToolkit().getScreenSize(); 
           Robot robot = new Robot(); 
           
           bufferedImage = new BufferedImage[num];
           
           for (int i = 0;i<num;i++){
               Thread.sleep(20);
               if(i==0)System.out.print(p_x+","+p_y+":"+p_x2+","+p_y2+"---"+d.width+":"+d.height);
               bufferedImage[i] = robot.createScreenCapture(new Rectangle(p_x,p_y,p_x2,p_y2)); 
              // d.width,d.height
           }
           jpgToGif(path,num);
   }
     public static void jpgToGif(String path,int num){
     AnimatedGifEncoder e = new AnimatedGifEncoder();
        e.setRepeat(0);
        e.start(path);
        for (int i = 0;i<num;i++){
            e.setDelay(20); 
            e.addFrame(bufferedImage[i]);
        }
        e.finish(); 
    }
     public Stogif (){
        getContentPane().add(new JPanelTest());

    }
     class JPanelTest extends JPanel{
        public JPanelTest(){
            setLayout(new FlowLayout(FlowLayout.CENTER, 10, 40));
        add(new JLabel("左上 x"));
        x1= new JTextField(4);
        add(x1);
        add(new JLabel("y"));
        y1= new JTextField(4);
        add(y1);
        add(new JLabel("右下 x"));
        x2= new JTextField(4);
        add(x2);
        add(new JLabel("y"));
        y2= new JTextField(4);
        add(y2);
        add(new JLabel("保存至"));
        JTextField newfile = new JTextField(24);
        add(newfile);
        JButton n = new JButton("...");
        add(n);
        n.addActionListener(new ActionListener(){
            @Override
            public void actionPerformed(ActionEvent e) {
                JFileChooser chooser = new JFileChooser();
                chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
                chooser.showOpenDialog(null);
                newfile.setText(chooser.getSelectedFile().getPath());
            }
        });
        JButton make = new JButton("生成照片");
        add(make);
        make.addActionListener(new ActionListener(){
            @Override
            public void actionPerformed(ActionEvent e) {
                
                try {
                    cut(Integer.parseInt(x1.getText().toString()),Integer.parseInt(y1.getText().toString()),
                            Integer.parseInt(x2.getText().toString()),Integer.parseInt(y2.getText().toString()),
                            newfile.getText().replaceAll("////", "////"),100);
                } catch (AWTException ex) {
                    Logger.getLogger(Stogif.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IOException ex) {
                    Logger.getLogger(Stogif.class.getName()).log(Level.SEVERE, null, ex);
                } catch (InterruptedException ex) {
                    Logger.getLogger(Stogif.class.getName()).log(Level.SEVERE, null, ex);
                }
                new MyJDialog(Stogif.this).setVisible(true);
                        
            }
        });

        }
          
    }
     class MyJDialog extends JDialog{
    //本实例代码可以看到，JDialog窗体和JFrame窗体形式基本相同，甚至在设置窗体的特性
    //时调用的方法名称都基本相同，如设置窗体的大小，设置窗体的关闭状态等
        public MyJDialog(Stogif frame){//定义一个构造方法
        //实例化一个JDialog类对象，指定对话框的父窗体，窗体标题，和类型
            super(frame,"第一个JDialog窗体",true);
            Container container=getContentPane();//创建一个容器
            container.add(new JLabel("保存成功"));//在容器中添加标签
            container.setBackground(Color.green);
            setBounds(120,120,100,100);
            setLocationRelativeTo(null);

         }

     }
}
    
   
    

