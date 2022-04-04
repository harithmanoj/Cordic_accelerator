`ifndef CORE_MONITOR_SVH
`define CORE_MONITOR_SVH

`include "types.svh"
`include "cordic_if.svh"

class core_monitor #(parameter width =  32, parameter int_width = 0);
  typedef Number #(width, int_width) fixed_pt;		// qn.m fixed point notation, n is integer width and m = width - int_width - 1
  typedef Angle #(width) 	  ang_type;				// Angle in q.m representation, m = width, with 1 representing 180 degrees, -1 representing -180 degrees 
  
  // CORDIC data inputs
  fixed_pt x_num;			// x value
  fixed_pt y_num;			// y value
  ang_type z_ang;			// angle value
  
  bit xOverflow;
  bit yOverflow;
  bit zOverflow;
  
  virtual CordicInterface.controller intf;
  
  function new(virtual CordicInterface.controller inp_intf);
    // Initialize internal variables
    x_num = new(0);
    y_num = new(0);
    z_ang = new(0);
    this.intf = inp_intf;    
  endfunction
  
  function bit sample();
    x_num.setBin(intf.xResult);
    y_num.setBin(intf.yResult);
    z_ang.setBin(intf.zResult);
    
	  xOverflow = intf.xOverflow;    
    yOverflow = intf.yOverflow;    
    zOverflow = intf.zOverflow;    
      
    return (xOverflow || yOverflow || zOverflow);
  endfunction
endclass

`endif
