 function[coins] = change(money)
 
 %initial amounts of each coin 
  quarter = 0; 
  dime = 0; 
  nickle = 0; 
  penny = 0; 
 
  % money = [quarter dime nickle penny]; 
  % money =[0 0 0 0]
  
  while money>0 % while money>=0  makes an infinte loop
 
      if money >= 25 
          money = money - 25; 
          quarter = quarter + 1;
      elseif money >= 10 
          money = money - 10; 
          dime = dime + 1;
      elseif money >= 5 
          money = money - 5; 
          nickle = nickle + 1;
      elseif money >= 1 
          money = money - 1; 
          penny = penny +1;
      end  
  end
  
  coins = [quarter dime nickle penny];