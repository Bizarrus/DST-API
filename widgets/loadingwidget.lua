local Widget = require "widgets/widget"
local Text = require "widgets/text"
local TEMPLATES = require "widgets/templates"

local images =
    IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS) and {
        {atlas="images/bg_spiral_fill_halloween1.xml", tex="bg_image1.tex"},
        {atlas="images/bg_spiral_fill_halloween2.xml", tex="bg_image2.tex"},
        {atlas="images/bg_spiral_fill_halloween3.xml", tex="bg_image3.tex"},
    }
    or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST) and {
        {atlas="images/bg_spiral_fill_christmas1.xml", tex="bg_image1.tex"},
        {atlas="images/bg_spiral_fill_christmas2.xml", tex="bg_image2.tex"},
    }
    or IsSpecialEventActive(SPECIAL_EVENTS.YOTG) and {
        {atlas="images/bg_spiral_fill_yotg1.xml", tex="bg_image1.tex"},
        {atlas="images/bg_spiral_fill_yotg2.xml", tex="bg_image2.tex"},
    }
    or {
        {atlas="images/bg_spiral_fill1.xml", tex="bg_image1.tex"},
        {atlas="images/bg_spiral_fill2.xml", tex="bg_image2.tex"},
        {atlas="images/bg_spiral_fill3.xml", tex="bg_image3.tex"},
        {atlas="images/bg_spiral_fill4.xml", tex="bg_image4.tex"},
        {atlas="images/bg_spiral_fill5.xml", tex="bg_image5.tex"},
        {atlas="images/bg_spiral_fill6.xml", tex="bg_image6.tex"},
        {atlas="images/bg_spiral_fill7.xml", tex="bg_image7.tex"},
        {atlas="images/bg_spiral_fill8.xml", tex="bg_image8.tex"},
    }

local LoadingWidget = Class(Widget, function(self, imageRand)
    Widget._ctor(self, "LoadingWidget")
    self.initialized = false
    self.forceShowNextFrame = false
    self.is_enabled = false
    self.image_random = imageRand or math.random(#images)
    self:Hide()
    self:StartUpdating()
end)

function LoadingWidget:ShowNextFrame()
    self.forceShowNextFrame = true
end

function LoadingWidget:SetEnabled(enabled)
    self.is_enabled = enabled
    if enabled then
        self:Show()
    else
        self:Hide()
    end
end

function LoadingWidget:KeepAlive(auto_increment)
    local just_initialized = false
    if self.initialized == false then
        local background_widget = self:AddChild(TEMPLATES.BackgroundSpiral())

        local vignette = self:AddChild(TEMPLATES.BackgroundVignette())

        local atlas = images[self.image_random].atlas
        local tex = images[self.image_random].tex

        local image = self:AddChild(Image(atlas, tex))
        image:SetScaleMode(SCALEMODE_FILLSCREEN)
        image:SetVAnchor(ANCHOR_MIDDLE)
        image:SetHAnchor(ANCHOR_MIDDLE)

        self.active_image = image
        self.bg = background_widget
        self.vig = vignette

        local local_loading_widget = self:AddChild(Text(UIFONT, 40))
        local_loading_widget:SetPosition(115, 60)
        local_loading_widget:SetRegionSize(130, 44)
        local_loading_widget:SetHAlign(ANCHOR_LEFT)
        local_loading_widget:SetVAlign(ANCHOR_BOTTOM)
        local_loading_widget:SetString(STRINGS.UI.NOTIFICATION.LOADING..".")

        self.loading_widget = local_loading_widget
        self.cached_string  = ""
        self.elipse_state = 0
        self.cached_fade_level = 0.0
        self.step_time = GetTime()
        self.initialized = true

        just_initialized = true
    end

    if self.initialized then
        if self.is_enabled then
            if TheFrontEnd and auto_increment == false then
                self.cached_fade_level = TheFrontEnd:GetFadeLevel()
            else
                self.cached_fade_level = 1.0
            end

            local fade_sq = self.cached_fade_level * self.cached_fade_level
            self.loading_widget:SetColour(243/255, 244/255, 243/255, fade_sq)
            self.bg:SetTint(FRONTEND_PORTAL_COLOUR[1], FRONTEND_PORTAL_COLOUR[2], FRONTEND_PORTAL_COLOUR[3], fade_sq)
            self.active_image:SetTint(1, 1, 1, fade_sq)
            self.vig:SetTint(1, 1, 1, fade_sq)

            local time = GetTime()
            local time_delta = time - self.step_time 
            local NEXT_STATE = 1.0
            if time_delta > NEXT_STATE or (auto_increment and not just_initialized) then
                if self.elipse_state == 0 then
                    self.loading_widget:SetString(STRINGS.UI.NOTIFICATION.LOADING.."..")
                    self.elipse_state = self.elipse_state + 1
                elseif self.elipse_state == 1 then
                    self.loading_widget:SetString(STRINGS.UI.NOTIFICATION.LOADING.."...")
                    self.elipse_state = self.elipse_state + 1
                else
                    self.loading_widget:SetString(STRINGS.UI.NOTIFICATION.LOADING..".")
                    self.elipse_state = 0
                end
                self.step_time = time
            end

            if 0.01 > self.cached_fade_level then
                self.is_enabled = false
                self:Hide()
            end
        end
    end
end

function LoadingWidget:OnUpdate()
    self:KeepAlive(self.forceShowNextFrame)
    self.forceShowNextFrame = false
end

return LoadingWidget
