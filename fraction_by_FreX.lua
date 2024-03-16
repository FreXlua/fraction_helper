script_author('FreX')
require 'lib.moonloader'
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local directIni = 'moonloader\\config\\frex.ini'

update_state = false

local script_vers = 2
local script_vers_text = '2.00'

local update_url = 'https://raw.githubusercontent.com/FreXlua/fraction_helper/main/upd.ini'
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = 'https://raw.githubusercontent.com/FreXlua/fraction_helper/main/fraction_by_FreX.lua'
local script_path = thisScript().path

local def = {
    config = {
    name='',
    podpis=''
  },
}

if not doesFileExist('moonloader/config/frex.ini') then inicfg.save(def, directIni) end

local mainIni = inicfg.load(nil, directIni)

function main()
    repeat wait(0) until isSampAvailable()
    
    local url = 'https://pastebin.com/raw/WPq39X13'
    local request = require('requests').get(url)
    local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))
    local function res()
        for n in request.text:gmatch('[^\r\n]+') do
            if nick:find(n) then return true end
        end
        return false
    end
    if not res() then
        sampAddChatMessage('��� �������! ��������� �� ���� ���-�� �������� ������ � ������� �� ugur_ibr �� @frex1ugur', 0xFF0000)
        thisScript():unload()
    else
        _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        nick = sampGetPlayerNickname(id)
        sampAddChatMessage('[INFO]: {FFFFFF}Loaded. Author: {20B2AA}t.me/frex1ugur {FFFFFF}�� {20B2AA}ugur_ibr{FFFFFF}. Cmd: {20B2AA}/fh', 0x20B2AA)
        sampRegisterChatCommand('vo1', cmd_vo1)
        sampRegisterChatCommand('vo2', cmd_vo2)
        sampRegisterChatCommand('vo3', cmd_vo3)
        sampRegisterChatCommand('vo4', cmd_vo4)
        sampRegisterChatCommand('fh', cmd_fh)
        sampRegisterChatCommand('name', cmd_name)
        sampRegisterChatCommand('podpis', cmd_podpis)
        downloadUrlToFile(update_url, update_path, function(id, status)
            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                updateIni = inicfg.load(nil, update_path)
                if tonumber(updateIni.info.vers) > script_vers then
                    sampAddChatMessage('���� ���������� �������! �������������...', 0xff0000)
                    update_state = true
                end
                os.remove(update_path)
            end
        end)

        while true do
            wait(0)
            
            if update_state then
                downloadUrlToFile(script_url, script_path, function(id, status)
                    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                        sampAddChatMessage('���������� �������!', 0xff0000)
                        thisScript():reload()
                    end
                end)
                break
            end
        end
    end
end

function cmd_name(arg)
    mainIni.config.name = arg
    if inicfg.save(mainIni, directIni) then
        sampAddChatMessage('�������', -1)
    end
end

function cmd_podpis(arg)
    mainIni.config.podpis = arg
    if inicfg.save(mainIni, directIni) then
        sampAddChatMessage('�������', -1)
    end
end

function cmd_fh()
    sampShowDialog(1488, '{ff0000}Fraction Helper by FreX', '{20B2AA}������ ������ ������ ��� ������� ������ � ������� ��������\n{20B2AA}������ �����!!! /name [���� ��� �� �������] � /podpis [���� ��� �� ����.]\n{20B2AA}�� ������� /vo1 /vo2 /vo3 �� ����������� ������� �������...\n{20B2AA}...�� ������� /vo4 �� ����������� ������� ����� ������� �����\n{20B2AA}���� ��� ����� ������� ������� �������� ���� �����/������ �������', '�������', '', 0)
end

function cmd_vo1()
    lua_thread.create(function()
        sampSendChat('� ������ �������� ��� ��������� ��������, ����� � �������.')
        wait(1000)
        sampSendChat('�������� �� ��, �������� ������ ��������� �� ��������?')
    end)
end

function cmd_vo2()
    lua_thread.create(function()
        sampSendChat('�������� �� �� ��������� �������� �� ������������� ����?')
    end)
end

function cmd_vo3()
    lua_thread.create(function()
        sampSendChat('�������� �� �� ����������� ��� �� �������� �����������, ��� � ����������������?')
    end)
end

function cmd_vo4()
    lua_thread.create(function()
        sampSendChat('/do �������� ������ ���� '.. mainIni.config.name ..'� ���������� �������� ����� � �����������.')
        wait(1500)
        sampSendChat('/me ������� �������� ������ ���� �����, ��������� �� ����� ������� �����.')
        wait(1500)
        sampSendChat('/me ������� ����� �� ����, ������ ������� ')
        wait(1500)
        sampSendChat('/do � ������� ����� ���������� ����� � ������ ����������.')
        wait(1500)
        sampSendChat('/me �������� ����� �������, �������� ���� � ������, ����� ���� ������ ���')
        wait(1500)
        sampSendChat('/me ������� �������� �� ����, ��������� ��� � ������� �������� ��������')
        wait(1500)
        sampSendChat('/do �������� �������� ��������.')
        wait(1500)
        sampSendChat('/do ���������� ���������: ��� ��������� ��������� ����� ��� ����� ���������....')
        wait(1500)
        sampSendChat('/do ...����������� ����� �����, �� ���������� ������� ��������� ....')
        wait(1500)
        sampSendChat('/do ...����� ����, ��� ������� ������� � ����� ���������� � ������...')
        wait(1500)
        sampSendChat('/do �������: '.. mainIni.config.podpis ..'  ������� ����������:')
        wait(5000)
        sampSendChat('/b /me ������������� � ����������, ���� ����� �� �����, � �������� ���')
        wait(5000)
        sampSendChat('/b /me ������ ������� � ������� �������, ������ ���������� �����, ����� ���� ������ ����� �����')
    end)
end

require('lib.samp.events').onShowDialog = function(dialogId, style, title, button1, button2, text)
    if dialogId == 25636 then
        sampSendDialogResponse(dialogId, 1, nil, nil)
        return false
    end
end