`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:53:18 04/19/2019 
// Design Name: 
// Module Name:    ASMBD 
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
module ASMBD(ssd_clk,clk, BD_clk, rst, clr, ent, change, led, sw, AN, seven_out);

input ssd_clk, clk, BD_clk, rst, clr, ent, change;
input [7:0] sw; 

output reg [5:0] led;
output [3:0] AN;
output [6:0] seven_out;

//registers
 reg [19:0] ssd;
 reg [15:0] password; 
 reg [15:0] inpassword;
 reg [5:0] current_state;
 reg [5:0] next_state;	
 reg [4:0] counter;
 reg checklock;
 
 wire[3:0] sec;
 reg [3:0] sectime;
 
assign sec = 4'b1101;
 


// parameters for States
parameter IDLE = 6'b100000; //idle state 
parameter GETFIRSTDIGIT = 6'b000001; // get_first_input_state 
parameter GETSECONDDIGIT = 6'b000010; //get_second input state
parameter GETTHIRDDIGIT = 6'b000011; //get third digit
parameter GETFOURTHDIGIT = 6'b000100; //get fourth digit

parameter GETNEWFIRST = 6'b000101;
parameter GETNEWSECOND = 6'b000110;
parameter GETNEWTHIRD = 6'b000111;
parameter GETNEWFOURTH = 6'b001000;

parameter LOCKED = 6'b001001;
parameter UNLOCKED = 6'b001010;
parameter CHECKPASS = 6'b001011;

//Backdoor state declarations
parameter BACKDOOR = 6'b001100;
parameter BACKDOOR1 = 6'b001101;
parameter BACKDOOR2 = 6'b001110;
parameter BACKDOOR3 = 6'b001111;
parameter BACKDOOR4 = 6'b010000;
parameter BACKDOOR5 = 6'b010001;
parameter BACKDOOR6 = 6'b010010;
parameter BACKDOOR7 = 6'b010011;
parameter BACKDOOR8 = 6'b010100;
parameter BACKDOOR9 = 6'b010101;
parameter BACKDOOR10 = 6'b010110;
parameter BACKDOOR11 = 6'b010111;
parameter BACKDOOR12 = 6'b011000;
parameter BACKDOOR13 = 6'b011001;
parameter BACKDOOR14 = 6'b011010;
parameter BACKDOOR15 = 6'b011011;
parameter BACKDOOR16 = 6'b011100;
			

// parameters for output
parameter C=5'b01111; 
parameter L=5'b01101; 
parameter five=5'b10011;
parameter d = 5'b10100;
parameter O = 5'b00000;
parameter P = 5'b10010;
parameter E = 5'b01110;
parameter n = 5'b01100;
parameter tire=5'b10001; 
parameter blank=5'b01010;
parameter zero = 1'b0;
parameter V = 5'b10111;
parameter three = 5'b00011;
parameter one = 5'b00001;


//Sequential part for state transitions
always @ (posedge clk or posedge rst)
	begin
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
			if(ent)
			begin
				if (counter==4'b0101)
					next_state = BACKDOOR; //added
				else
					next_state = GETFIRSTDIGIT;
			end
			else if (clr == 1)
				next_state = GETFIRSTDIGIT;
			
			else 
				next_state = current_state;	
		end
		
		//BACKDOOR
		else if (current_state == BACKDOOR)
		begin
			if (ent)
				next_state = LOCKED;
			else
				next_state = BACKDOOR1;
		end
		
		//BACKDOOR1
		else if (current_state == BACKDOOR1)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR2;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR2		
		else if (current_state == BACKDOOR2)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR3;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR3
		else if (current_state == BACKDOOR3)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR4;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR4	
		else if (current_state == BACKDOOR4)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR5;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR5
		else if (current_state == BACKDOOR5)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR6;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR6
		else if (current_state == BACKDOOR6)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR7;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR7
		else if (current_state == BACKDOOR7)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR8;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR8
		else if (current_state == BACKDOOR8)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR9;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR9
		else if (current_state == BACKDOOR9)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR10;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR10
		else if (current_state == BACKDOOR10)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR11;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR11
		else if (current_state == BACKDOOR11)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR12;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR12
		else if (current_state == BACKDOOR12)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR13;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR13
		else if (current_state == BACKDOOR13)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR14;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR14
		else if (current_state == BACKDOOR14)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR15;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR15
		else if (current_state == BACKDOOR15)
		begin 
			if (sectime == sec)
				next_state = BACKDOOR16;
			else 
				next_state = current_state;
		end
		
		//BACKDOOR16
		else if (current_state == BACKDOOR16)
		begin 
			if (sectime == sec)
				next_state = LOCKED;
			else 
				next_state = current_state;
		end

		//LOCKED STATE
		else if ( current_state == LOCKED )
		begin
			 if (ent == 1)
			 begin
				if (counter==4'b0101)
					next_state = BACKDOOR;
				else
					next_state = GETFIRSTDIGIT;
			 end
			 else
			 	next_state = current_state;
		end

		//FIRST DIGIT
		else if ( current_state == GETFIRSTDIGIT )
		begin
			 if (ent == 1)
			 begin
				if (counter==4'b0101)
					next_state = BACKDOOR; //added
				else
					next_state = GETSECONDDIGIT;
			end
			 else if (clr == 1)
				next_state = GETFIRSTDIGIT;
			
			 else
			 	next_state = current_state;
		end

		//SECOND DIGIT
		else if (current_state == GETSECONDDIGIT)
		begin
			if (ent == 1)
			begin
				if (counter==4'b0101)
					next_state = BACKDOOR; //added
				else
				next_state = GETTHIRDDIGIT;
			end
			else if (clr == 1)
				next_state = GETFIRSTDIGIT;
			else 
				next_state = current_state;	
		end
		
		//THIRD DIGIT
		else if ( current_state == GETTHIRDDIGIT )
		begin
			 if (ent == 1)
			 begin
				if (counter==4'b0101)
					next_state = BACKDOOR; //added
				else
			 	next_state = GETFOURTHDIGIT;
			end
			 else if (clr == 1)
				next_state = GETFIRSTDIGIT;
			
			 else
			 	next_state = current_state;
		end
		
		//FOURTH DIGIT
		else if ( current_state == GETFOURTHDIGIT )
		begin
			 if (ent == 1)
			 begin
			 if (counter==4'b0101)
				next_state = BACKDOOR; //added
			else
			 	next_state = CHECKPASS;
			end
			 else if (clr == 1)
				next_state = GETFIRSTDIGIT;
			
			 else
			 	next_state = current_state;
		end
		
		//UNLOCKED STATE
		else if ( current_state == UNLOCKED )
		begin
			 if (ent == 1) 
			 begin
				if (counter==4'b0101)
					next_state = BACKDOOR; //added
			   else
					next_state = GETFIRSTDIGIT;
			 end
			 else if (change == 1)
				next_state = GETNEWFIRST;
			
			 else
			 	next_state = current_state;
		end
		
		//NEW FIRST
		else if ( current_state == GETNEWFIRST )
		begin
			 if (ent == 1)
			 begin
				if (counter==4'b0101)
					next_state = BACKDOOR; //added
				else
					next_state = GETNEWSECOND;
			 end
			 else if (clr == 1)
					next_state = GETNEWFIRST;
			 else
			 	next_state = current_state;
		end
		
		//NEW SECOND
		else if ( current_state == GETNEWSECOND )
		begin
			 if (ent == 1)
			 begin
				if (counter==4'b0101)
					next_state = BACKDOOR; //added
				else
					next_state = GETNEWTHIRD;
			 end
			 else if (clr == 1)
				next_state = GETNEWFIRST;
			
			 else
			 	next_state = current_state;
		end
		
		//NEW THIRD
		else if ( current_state == GETNEWTHIRD )
		begin
			 if (ent == 1)
			 begin
				if (counter==4'b0101)
					next_state = BACKDOOR; //added
				else
					next_state = GETNEWFOURTH;
			 end
			 else if (clr == 1)
				next_state = GETNEWFIRST;
			
			 else
			 	next_state = current_state;
		end
		
		//NEW FOURTH 
		else if ( current_state == GETNEWFOURTH )
		begin
			 if (ent == 1)
			 begin
				if (counter==4'b0101)
					next_state = BACKDOOR; //added
				else
			 	next_state = UNLOCKED;
			 end
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
				else                    
					next_state = LOCKED;
			end 
			
			else
			begin
				if (checklock == 1) ////stuff
					next_state = LOCKED;
				else 
					next_state = UNLOCKED;
			end
		end
		
	end


	 //Sequential part for control registers, this part is responsible from assigning control registers or stored values
	 //or posedge rst
	always @ (posedge clk or posedge rst)
	begin
		if(rst)
		begin
			//inpassword[15:0]<=0; // password which is taken coming from user, 
			password[15:0]<=0;
			checklock <= 1;
			counter<=0;
		end

		else 
		begin
			if(current_state == IDLE)
			begin
				//checklock <= 1;
			 	password[15:0] <= 16'b0000000000000000; 
				if(ent)
				begin
					if(sw[7:4] ==4'b1010)
						counter<=counter + 1'b1;
					else
						counter<=0;
				end
			end
			
				
			else if (current_state == LOCKED)
			begin
				checklock <= 1;
				if (ent)
				begin 
						if (sw[7:4] ==4'b1010)
							counter <= counter+1'b1;
						else
							counter<=0;
				end
				else begin
						if (sw[7:4] !=4'b1010)
							counter<=0;
				end 
			end
							
				
			else if (current_state == UNLOCKED)
			begin
				checklock <= 0;
				if (ent)
				begin 
						if (sw[7:4] ==4'b1010)
							counter <= counter+1'b1;
						else
							counter<=0;
				end
				else begin
						if (sw[7:4] !=4'b1010)
							counter<=0;
				end 
			end
				
		
	
			else if(current_state == GETFIRSTDIGIT)
			begin
				if(ent==1)
				begin
					inpassword[15:12]<=sw[3:0]; 
					if(sw[7:4] ==4'b1010)
						counter<=counter + 1'b1;
					else
						counter<=0;
				end
			end

			else if (current_state == GETSECONDDIGIT)
			begin
				if(ent==1)
				begin
					inpassword[11:8]<=sw[3:0]; 
					if(sw[7:4] ==4'b1010)
						counter<=counter + 1'b1;
					else
						counter<=0;
				end
			end
			
			else if (current_state == GETTHIRDDIGIT)
			begin
				if(ent==1)
				begin
					inpassword[7:4]<=sw[3:0]; 
					if(sw[7:4] ==4'b1010)
						counter<=counter + 1'b1;
					else
						counter<=0;
				end
					
			end

			else if (current_state == GETFOURTHDIGIT)
			begin
				if(ent==1)
				begin
					inpassword[3:0]<=sw[3:0]; 
					if(sw[7:4] ==4'b1010)
						counter<=counter + 1'b1;
					else
						counter<=0;
				end
			end

			else if(current_state == GETNEWFIRST)
			begin
				if(ent==1)
				begin
					password[15:12]<=sw[3:0];
					if(sw[7:4] ==4'b1010)
						counter<=counter + 1'b1;
					else
						counter<=0;
				end					
			end
			
			else if (current_state == GETNEWSECOND)
			begin
				if(ent==1)
				begin
					password[11:8]<=sw[3:0]; 
					if(sw[7:4] ==4'b1010)
						counter<=counter + 1'b1;
					else
						counter<=0;
				end
			end
			
			else if (current_state == GETNEWTHIRD)
			begin
				if(ent==1)
				begin
					password[7:4]<=sw[3:0]; 
					if(sw[7:4] ==4'b1010)
						counter<=counter + 1'b1;
					else
						counter<=0;
				end
			end

			else if (current_state == GETNEWFOURTH)
			begin
				if(ent==1)
				begin
					password[3:0]<=sw[3:0]; 
					if(sw[7:4] ==4'b1010)
						counter<=counter + 1'b1;
					else
						counter<=0;
				end
			end
			
			else if (current_state == BACKDOOR)
			begin
			 	password[15:12] <= 3'b0000; 
				password[11:8] <= 3'b0011; 
				password[7:4] <= 3'b0001; 
				password[3:0] <= 3'b0001; 
				//counter <= 0;
			end
			
			else if (current_state == BACKDOOR1)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			 	password[15:12] <= 3'b0000; 
				password[11:8] <= 3'b0011; 
				password[7:4] <= 3'b0001; 
				password[3:0] <= 3'b0001; 
			end
			
			else if (current_state == BACKDOOR2)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR3)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR4)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end

			end
			
			else if (current_state == BACKDOOR5)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR6)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR7)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end

			end
			
			else if (current_state == BACKDOOR8)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR9)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR10)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR11)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR12)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR13)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR14)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR15)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			end
			
			else if (current_state == BACKDOOR16)
			begin
				if (sectime != sec)
					sectime <= sectime +1;
				else
				begin
					sectime <= 0;
				end
			 	password[15:12] <= 3'b0000; 
				password[11:8] <= 3'b0011; 
				password[7:4] <= 3'b0001; 
				password[3:0] <= 3'b0001; 
				counter <= 0;
			end
			
		end
	end


	// Sequential part for outputs; this part is responsible from outputs; i.e. SSD and LEDS


	always @(posedge clk )
	begin
		//backdoorclk <= 0;
			
	/*	if(rst==1)
		begin
			ssd <= {C, L, five, d};	
			led <= IDLE;
		end*/
		
		/*else begin*/
			if(current_state == IDLE)
			begin
				ssd <= {C, L, five, d};	
				led <= IDLE;
			end

			else if(current_state == GETFIRSTDIGIT)
			begin
				ssd <= { zero,sw[3:0], blank, blank, blank};	
				led <= GETFIRSTDIGIT;
			end

			else if(current_state == GETSECONDDIGIT)
			begin
				ssd <= { tire , zero,sw[3:0], blank, blank};	
				led <= GETSECONDDIGIT;
			end
		
			else if(current_state == GETTHIRDDIGIT)
			begin
				ssd <= { tire , tire, zero,sw[3:0], blank};	
				led <= GETTHIRDDIGIT;
			end
		
			else if(current_state == GETFOURTHDIGIT)
			begin
				ssd <= { tire , tire, tire, zero,sw[3:0]};	
				led <= GETFOURTHDIGIT;
			end
		
			else if(current_state == GETNEWFIRST)
			begin
				ssd <= { zero,sw[3:0], blank, blank,blank};	
				led <= GETNEWFIRST;
			end
		
			else if(current_state == GETNEWSECOND)
			begin
				ssd <= { zero,password[15:12], zero,sw[3:0], blank, blank};	 	
				led <= GETNEWSECOND;
			end
		
			else if(current_state == GETNEWTHIRD)
			begin
				ssd <= { zero,password[15:12] , zero,password[11:8], zero,sw[3:0], blank};	
				led <= GETNEWTHIRD;
			end
		
			else if(current_state == GETNEWFOURTH)
			begin
				ssd <= { zero,password[15:12] , zero,password[11:8], zero,password[7:4], zero,sw[3:0]};	
				led <= GETNEWFOURTH;
			end
		
			else if(current_state == LOCKED)
			begin
				ssd <= {C,L,five,d};
				led <= LOCKED;
			end
		
			else if(current_state == UNLOCKED)
			begin
				ssd <= {O,P,E,n};
				led <= UNLOCKED;
			end
		
			else if(current_state == BACKDOOR)
				led <= BACKDOOR;
			
			else if (current_state == BACKDOOR1)
				ssd <= {blank, blank, blank, blank};
			
			else if (current_state == BACKDOOR2)
				ssd <= {one,blank,blank,blank};
			
			else if (current_state == BACKDOOR3)
				ssd <= {one,blank,L,blank};
			
			else if (current_state == BACKDOOR4)
				ssd <= {one,blank,L,O};
			
			else if (current_state == BACKDOOR5)
				ssd <= {blank,L,O,V};
			
			else if (current_state == BACKDOOR6)
				ssd <= {L,O,V,E};
		
			else if (current_state == BACKDOOR7)
				ssd <= {O,V,E,blank};
			
			else if (current_state == BACKDOOR8)
				ssd <= {V,E,blank,E};
			
			else if (current_state == BACKDOOR9)
				ssd <= {E,blank,E,C};
			
			else if (current_state == BACKDOOR10)
				ssd <= {blank,E,C,three};
			
			else if (current_state == BACKDOOR11)
				ssd <= {E,C,three,one};
			
			else if (current_state == BACKDOOR12)
				ssd <= {C,three,one,one};
			
			else if (current_state == BACKDOOR13)
				ssd <= {three,one,one,blank};
			
			else if (current_state == BACKDOOR14)
				ssd <= {one,one,blank,blank};
			
			else if (current_state == BACKDOOR15)
				ssd <= {one,blank,blank,blank};
				
			else if (current_state == BACKDOOR16)
				ssd <= {blank,blank,blank};
		
	end




	seven_segment SSD(ssd_clk,ssd,AN,seven_out);



endmodule
