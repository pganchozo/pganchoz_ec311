`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:06 04/14/2019 
// Design Name: 
// Module Name:    ASM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//STATE DECLARATIONS DONE AND REGISTER DONE

module ASM (clk, rst, clr, ent, change, led, ssd, sw);

input clk, rst, clr, ent, change;
input [3:0] sw; 

output reg [5:0] led;
output reg [19:0] ssd;

//registers
 reg [15:0] password; 
 reg [15:0] inpassword;
 reg [5:0] current_state;
 reg [5:0] next_state;	


// parameters for States
parameter IDLE = 6'b000000; //idle state 
parameter GETFIRSTDIGIT = 6'b000001; // get_first_input_state 
parameter GETSECONDIGIT = 6'b000010; //get_second input state
parameter GETTHIRDDIGIT = 6'b000011; //get third digit
parameter GETFOURTHDIGIT = 6'b000100; //get fourth digit

parameter GETNEWFIRST = 6'b000101;
parameter GETNEWSECOND = 6'b000110;
parameter GETNEWTHIRD = 6'b000111;
parameter GETNEWFOURTH = 6'b001000;

parameter LOCKED = 6'b001001;
parameter UNLOCKED = 6'b001010;
parameter CHECKPASS = 6'b001011;

// parameters for output, you will need more obviously
parameter C=5'b?????; // you should decide on what should be the value of C, the answer depends on your binary_to_segment file implementation
parameter L=5'b?????; // same for L and for other guys, each of them 5 bit. IN ssd module you will provide 20 bit input, each 5 bit will be converted into 7 bit SSD in binary to segment file.
parameter tire=5'b?????; 
parameter blank=5'b?????;


//Sequential part for state transitions
always @ (posedge clk or posedge rst)
	begin
		// your code goes here
		if(rst==1)
		current_state<= IDLE;
		else
		current_state<= next_state;
		
	end

// combinational part - next state definitions
always @ (*)
	begin
		if(current_state == IDLE)
		begin
			assign password[15:0]=16'b0000000000000000;
			// your code goes here
			if(ent == 1)
				next_state = GETFIRSTDIGIT;
			else if (clr == 1)
				next_state = GETFIRSTDIGIT;
			else 
				next_state = current_state;	
		end

		//LOCKED STATE
		else if ( current_state == LOCKED )
		begin
			 if (ent == 1)
			 	next_state = GETFIRSTDIGIT;
			 else
			 	next_state = current_state;
		end

		//FIRST DIGIT
		else if ( current_state == GETFIRSTDIGIT )
		begin
			 if (ent == 1)
			 	next_state = GETSECONDIGIT;
			 else if (clr == 1)
				next_state = GETFIRSTDIGIT;
			 else
			 	next_state = current_state;
		end

		//SECOND DIGIT
		else if (current_state == GETSECONDDIGIT)
		begin
			if (ent == 1)
				next_state = GETTHIRDDIGIT;
			else if (clr == 1)
				next_state = GETFIRSTDIGIT;
			else 
				next_state = current_state;	
		end
		
		//THIRD DIGIT
		else if ( current_state == GETTHIRDDIGIT )
		begin
			 if (ent == 1)
			 	next_state = GETFOURTHDIGIT;
			 else if (clr == 1)
				next_state = GETFIRSTDIGIT;
			 else
			 	next_state = current_state;
		end
		
		//FOURTH DIGIT
		else if ( current_state == GETFOURTHDIGIT )
		begin
			 if (ent == 1)
			 	next_state = CHECKPASS;
			 else if (clr == 1)
				next_state = GETFIRSTDIGIT;
			 else
			 	next_state = current_state;
		end
		
		//UNLOCKED STATE
		else if ( current_state == UNLOCKED )
		begin
			 if (ent == 1) //check if correct idk maybe maybe not !!!!!!
			 	next_state = GETNEWFIRST;
			 else if (change == 1)
				next_state = GETNEWFIRST;
			 else
			 	next_state = current_state;
		end
		
		//NEW FIRST
		else if ( current_state == GETNEWFIRST )
		begin
			 if (ent == 1)
			 	next_state = GETNEWSECOND;
			 else if (clr == 1)
				next_state = GETNEWFIRST;
			 else
			 	next_state = current_state;
		end
		
		//NEW SECOND
		else if ( current_state == GETNEWSECOND )
		begin
			 if (ent == 1)
			 	next_state = GETNEWTHIRD;
			 else if (clr == 1)
				next_state = GETNEWFIRST;
			 else
			 	next_state = current_state;
		end
		
		//NEW THIRD
		else if ( current_state == GETNEWTHIRD )
		begin
			 if (ent == 1)
			 	next_state = GETNEWFOURTH;
			 else if (clr == 1)
				next_state = GETNEWFIRST;
			 else
			 	next_state = current_state;
		end
		
		//NEW FOURTH 
		else if ( current_state == GETNEWFOURTH )
		begin
			 if (ent == 1)
			 	next_state = LOCKED;
			 else if (clr == 1)
				next_state = GETNEWFIRST;
			 else
			 	next_state = current_state;
		end
		
		
		//CHECK PASSWORD
		else if (current_state == CHECKPASS)
		begin
			if (inpassword == password)
			begin
				if (checklock == 1)
					next_state = UNLOCKED;
				else                              //if it's unlocked 
					next_state = LOCKED;
			end 
			
			else
			begin
				if (checklock == 1)
					next_state = LOCKED;
				else 
					next_state = UNLOCKED;
			end
		end
	end


	 //Sequential part for control registers, this part is responsible from assigning control registers or stored values
	always @ (posedge clk or posedge rst)
	begin
		if(rst)
		begin
			inpassword[15:0]<=0; // password which is taken coming from user, 
			password[15:0]<=0;
		end

		else 
		begin
			if(current_state == IDLE)
			begin
			 	password[15:0] <= 16'b0000000000000000; 
				 // you may need to add extra things here.
			end
			
			
			else if (current_state == LOCKED | current_state == IDLE)
				checklock = 1;
				
			else if (curernt_state == UNLOCKED)
				checklock = 0;
		
	
			else if(current_state == GETFIRSTDIGIT)
			begin
				if(ent==1)
					inpassword[15:12]<=sw[3:0]; // inpassword is the password entered by user, first 4 digin will be equal to current switch values
			end

			else if (current_state == GETSECONDDIGIT)
			begin
				if(ent==1)
					inpassword[11:8]<=sw[3:0]; 
			end
			
			else if (current_state == GETTHIRDDIGIT)
			begin
				if(ent==1)
					inpassword[7:4]<=sw[3:0]; 
			end

			else if (current_state == GETFOURTHDIGIT)
			begin
				if(ent==1)
					inpassword[3:0]<=sw[3:0]; 
			end

			else if(current_state == GETNEWFIRST)
			begin
				if(ent==1)
					password[15:12]<=sw[3:0]; 
			end
			
			else if (current_state == GETNEWSECOND)
			begin
				if(ent==1)
					password[11:8]<=sw[3:0]; 
			end
			
			else if (current_state == GETNEWTHIRD)
			begin
				if(ent==1)
					password[7:4]<=sw[3:0]; 
			end

			else if (current_state == GETNEWFOURTH)
			begin
				if(ent==1)
					password[3:0]<=sw[3:0]; 
			end
		end
	end


	// Sequential part for outputs; this part is responsible from outputs; i.e. SSD and LEDS


	always @(posedge clk)
	begin

		if(current_state == IDLE)
		begin
		ssd <= {C, L, five, d};	//CLSD
		end

		else if(current_state == GETFIRSTDIGIT)
		begin
		ssd <= { 0,sw[3:0], blank, blank, blank};	// you should modify this part slightly to blink it with 1Hz. The 0 is at the beginning is to complete 4bit SW values to 5 bit.
		end

		else if(current_state == GETSECONDIGIT)
		begin
		ssd <= { tire , 0,sw[3:0], blank, blank};	// you should modify this part slightly to blink it with 1Hz. 0 after tire is to complete 4 bit sw to 5 bit. Padding 4 bit sw with 0 in other words.	
		end
		/*
		 You need more else if obviously

		*/
	end


endmodule
