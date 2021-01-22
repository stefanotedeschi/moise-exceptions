package simulator;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;

public class Site implements HousePart {

    private boolean status;
    
    public Site(boolean status) {
        super();
        this.status = status;
    }
    
    public void draw(Dimension size, Graphics2D g){
        if(status) {
            g.setColor(Color.GREEN);
        }
        else {
            g.setColor(Color.RED);
        }
        g.fillRect(0, size.height-200, size.width,100);
        g.setColor(Color.BLACK);
        if(status) {
            g.drawString("Site OK", 20, size.height-185);
        }
        else {
            g.drawString("Site FLOODED!", 20, size.height-185);
        }
    }

}
