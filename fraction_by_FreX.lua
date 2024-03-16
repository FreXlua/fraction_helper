script_author('FreX')
require 'lib.moonloader'
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local directIni = 'moonloader\\config\\frex.ini'

update_state = false

local script_vers = 2
local script_vers_text = '2.00'

local update_url = 'https://raw.githubusercontent.com/FreXlua/fraction_helper/main/upd.ini'
local update_path = getWorkingDirectory() .. '/upd.ini'

local script_url = 'https://raw.githubusercontent.com/FreXlua/fraction_helper/main/fraction_helper_by_FreX.lua'
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
        sampAddChatMessage('Нет доступа! Свяжитесь со мной что-бы получить доступ к скрипту ДС ugur_ibr ТГ @frex1ugur', 0xFF0000)
        thisScript():unload()
    else
        _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        nick = sampGetPlayerNickname(id)

        downloadUrlToFile(update_url, update_path, function(id, status)
            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                updateIni = inicfg.load(nil, update_path)
                if tonumber(updateIni.info.vers) > script_vers then
                    sampAddChatMessage('Есть обновление скрипта! Устанавливаем...', 0xff0000)
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
                        sampAddChatMessage('Обновление скачано!', 0xff0000)
                        thisScript():reload()
                    end
                end)
                break
            end
        end
        sampAddChatMessage('[INFO]: {FFFFFF}Loaded. Author: {20B2AA}t.me/frex1ugur {FFFFFF}ДС {20B2AA}ugur_ibr{FFFFFF}. Cmd: {20B2AA}/fh', 0x20B2AA)
        sampRegisterChatCommand('vo1', cmd_vo1)
        sampRegisterChatCommand('vo2', cmd_vo2)
        sampRegisterChatCommand('vo3', cmd_vo3)
        sampRegisterChatCommand('vo4', cmd_vo4)
        sampRegisterChatCommand('fh', cmd_fh)
        sampRegisterChatCommand('name', cmd_name)
        sampRegisterChatCommand('podpis', cmd_podpis)
    end
end

function cmd_name(arg)
    mainIni.config.name = arg
    if inicfg.save(mainIni, directIni) then
        sampAddChatMessage('Успешно', -1)
    end
end

function cmd_podpis(arg)
    mainIni.config.podpis = arg
    if inicfg.save(mainIni, directIni) then
        sampAddChatMessage('Успешно', -1)
    end
end

function cmd_fh()
    sampShowDialog(1488, '{ff0000}Fraction Helper by FreX', '{20B2AA}Данный хелпер создан для продажи рангов в Частных Фракциях\n{20B2AA}ВАЖНЫЙ ПУНКТ!!! /name [Ваше имя на русском] и /podpis [Ваше имя на англ.]\n{20B2AA}По команде /vo1 /vo2 /vo3 вы спрашиваете обычные вопросы...\n{20B2AA}...по команде /vo4 вы отыгрываете главный пункт продажи ранга\n{20B2AA}Есть еще много функций которые упрощают игру Замам/Лидеру фракции', 'Закрыть', '', 0)
end

function cmd_vo1()
    lua_thread.create(function()
        sampSendChat('Я должен задавать вам несколько вопросов, начнём с первого.')
        wait(1000)
        sampSendChat('Согласны ли вы, оплатить полную стоимость за контракт?')
    end)
end

function cmd_vo2()
    lua_thread.create(function()
        sampSendChat('Согласны ли вы подписать контракт на неопределённый срок?')
    end)
end

function cmd_vo3()
    lua_thread.create(function()
        sampSendChat('Согласны ли вы подчиняться тем же правилам организации, как и законодательству?')
    end)
end

function cmd_vo4()
    lua_thread.create(function()
        sampSendChat('/do Напротив правой руки '.. mainIni.config.name ..'а находиться закрытая тумба с контрактами.')
        wait(1500)
        sampSendChat('/me немного протянув правую руку вперёд, схватился за ручку полочки тумбы.')
        wait(1500)
        sampSendChat('/me потянув ручку на себя, открыл полочку ')
        wait(1500)
        sampSendChat('/do В полочке тумбы находиться Бланк с пустым контрактом.')
        wait(1500)
        sampSendChat('/me отпустив ручку полочки, протянул руку к бланку, после чего достал его')
        wait(1500)
        sampSendChat('/me положив контракт на стол, развернул его в сторону человека напротив')
        wait(1500)
        sampSendChat('/do Контракт напротив человека.')
        wait(1500)
        sampSendChat('/do Содержимое контракта: Для получения желаемого ранга вам нужно перевести....')
        wait(1500)
        sampSendChat('/do ...Определённую сумму денег, на банковскую яйчейку Директора ....')
        wait(1500)
        sampSendChat('/do ...После чего, вам выдадут бейджик с новой должностью и формой...')
        wait(1500)
        sampSendChat('/do Подпись: '.. mainIni.config.podpis ..'  Подпись покупателя:')
        wait(5000)
        sampSendChat('/b /me ознакомившись с контрактом, взял ручку со стола, и подписал его')
        wait(5000)
        sampSendChat('/b /me достав телефон с правого кармана, открыл приложение банка, после чего перевёл сумму денег')
    end)
end

require('lib.samp.events').onShowDialog = function(dialogId, style, title, button1, button2, text)
    if dialogId == 25636 then
        sampSendDialogResponse(dialogId, 1, nil, nil)
        return false
    end
end