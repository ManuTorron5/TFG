classdef D2 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        GaleraMenu                     matlab.ui.container.Menu
        VanDerPolMenu                  matlab.ui.container.Menu
        LotkaVolterraMenu              matlab.ui.container.Menu
        CompeticinMenu                 matlab.ui.container.Menu
        DuffingMenu                    matlab.ui.container.Menu
        PnduloMenu                     matlab.ui.container.Menu
        MtodosMenu                     matlab.ui.container.Menu
        MtododeEulerMenu               matlab.ui.container.Menu
        DiferenciascentradasMenu       matlab.ui.container.Menu
        RungeKuttaorden4Menu           matlab.ui.container.Menu
        AdamsBashforthorden4Menu       matlab.ui.container.Menu
        Nystrmorden4Menu               matlab.ui.container.Menu
        ode45Menu                      matlab.ui.container.Menu
        ode23Menu                      matlab.ui.container.Menu
        ode113Menu                     matlab.ui.container.Menu
        ode15sMenu                     matlab.ui.container.Menu
        ode23sMenu                     matlab.ui.container.Menu
        ode23tMenu                     matlab.ui.container.Menu
        ode23tbMenu                    matlab.ui.container.Menu
        OpcionesMenu                   matlab.ui.container.Menu
        IsoclinasMenu                  matlab.ui.container.Menu
        EcuacionesPanel                matlab.ui.container.Panel
        EditFieldX                     matlab.ui.control.EditField
        EditFieldY                     matlab.ui.control.EditField
        Label                          matlab.ui.control.Label
        Label_2                        matlab.ui.control.Label
        xLabel                         matlab.ui.control.Label
        yLabel                         matlab.ui.control.Label
        VamosButton                    matlab.ui.control.Button
        AtrsButton                     matlab.ui.control.Button
        ParmetrosPanel                 matlab.ui.container.Panel
        EditFieldP1Name                matlab.ui.control.EditField
        EditFieldP1                    matlab.ui.control.EditField
        EditFieldP2Name                matlab.ui.control.EditField
        EditFieldP2                    matlab.ui.control.EditField
        EditFieldP3Name                matlab.ui.control.EditField
        EditFieldP3                    matlab.ui.control.EditField
        EditFieldP4Name                matlab.ui.control.EditField
        EditFieldP4                    matlab.ui.control.EditField
        Label_3                        matlab.ui.control.Label
        Label_4                        matlab.ui.control.Label
        Label_5                        matlab.ui.control.Label
        Label_6                        matlab.ui.control.Label
        Label_7                        matlab.ui.control.Label
        EditFieldP6Name                matlab.ui.control.EditField
        EditFieldP6                    matlab.ui.control.EditField
        Label_8                        matlab.ui.control.Label
        EditFieldP5Name                matlab.ui.control.EditField
        EditFieldP5                    matlab.ui.control.EditField
        TamaodelaventanaPanel          matlab.ui.container.Panel
        MnxEditFieldLabel              matlab.ui.control.Label
        MnxEditField                   matlab.ui.control.NumericEditField
        MxxEditFieldLabel              matlab.ui.control.Label
        MxxEditField                   matlab.ui.control.NumericEditField
        MnyEditFieldLabel              matlab.ui.control.Label
        MnyEditField                   matlab.ui.control.NumericEditField
        MxyEditFieldLabel              matlab.ui.control.Label
        MxyEditField                   matlab.ui.control.NumericEditField
        OtrosdatosPanel                matlab.ui.container.Panel
        LongituddelintervaloEditFieldLabel  matlab.ui.control.Label
        LongituddelintervaloEditField  matlab.ui.control.NumericEditField
        PuntosEditFieldLabel           matlab.ui.control.Label
        PuntosEditField                matlab.ui.control.NumericEditField
        SalirButton                    matlab.ui.control.Button
        TrayectoriasButtonGroup        matlab.ui.container.ButtonGroup
        AdelanteButton                 matlab.ui.control.RadioButton
        AtrsButton_2                   matlab.ui.control.RadioButton
        AdelanteyatrsButton            matlab.ui.control.RadioButton
    end

    
    properties (Access = private)
        metodo = @rk4; % Método a utilizar
        flag_fw = 1; % Flag trayectorias hacia adelante
        flag_bw = 1; %Flag trayectorias hacia atrás
        color = 'm'; % Color para pintar la trayectoria (en principio depende del método usado)
        fxy = 0; % Función simbólica de x'
        gxy = 0; % Función simbólica de y'
    end
    
  
    

    methods (Access = private)

        % Button pushed function: VamosButton
        function VamosButtonPushed(app, event)
           % Despajamos todas las figuras
           figure(1);
           clf;
           figure(2);
           clf;
            
           xpstr = app.EditFieldX.Value;
           ypstr = app.EditFieldY.Value;
           
           % Reemplazar nombre de los parámetros por valor de los parámetros
           xpstr = replace(xpstr, app.EditFieldP1Name.Value, app.EditFieldP1.Value);
           xpstr = replace(xpstr, app.EditFieldP2Name.Value, app.EditFieldP2.Value);
           xpstr = replace(xpstr, app.EditFieldP3Name.Value, app.EditFieldP3.Value);
           xpstr = replace(xpstr, app.EditFieldP4Name.Value, app.EditFieldP4.Value);
           xpstr = replace(xpstr, app.EditFieldP5Name.Value, app.EditFieldP5.Value);
           xpstr = replace(xpstr, app.EditFieldP6Name.Value, app.EditFieldP6.Value);
           
           ypstr = replace(ypstr, app.EditFieldP1Name.Value, app.EditFieldP1.Value);
           ypstr = replace(ypstr, app.EditFieldP2Name.Value, app.EditFieldP2.Value);
           ypstr = replace(ypstr, app.EditFieldP3Name.Value, app.EditFieldP3.Value);
           ypstr = replace(ypstr, app.EditFieldP4Name.Value, app.EditFieldP4.Value);
           ypstr = replace(ypstr, app.EditFieldP5Name.Value, app.EditFieldP5.Value);
           ypstr = replace(ypstr, app.EditFieldP6Name.Value, app.EditFieldP6.Value);
           
           xaux = xpstr;
           yaux = ypstr; 
          
           
           % Abrimos una figura si antes no existía
          
           figure(1);
           %axis square; % Ejes del mismo tamaño
           
           % Formato de la figure
           xlim([app.MnxEditField.Value, app.MxxEditField.Value]);
           ylim([app.MnyEditField.Value, app.MxyEditField.Value]);
           hold on;
           grid on;
           %grid minor;
           
           
           % Pintar las velocidades del diagrama
           
           % Funciones elemento a elemento
           xaux = replace(xaux, "*", ".*");
           xaux = replace(xaux, "^", ".^");
           xaux = replace(xaux, "/", "./");
           
           yaux = replace(yaux, "*", ".*");
           yaux = replace(yaux, "^", ".^");
           yaux = replace(yaux, "/", "./");
           
           
           % Generar mallado de puntos donde pintar las flechas 
           x = linspace(app.MnxEditField.Value, app.MxxEditField.Value, 20);
           y = linspace(app.MnyEditField.Value, app.MxyEditField.Value, 20);
           
           [x, y] = meshgrid(x,y);
            
           v = @(x, y) eval(xaux);
           w = @(x, y) eval(yaux);
           
           app.fxy = v;
           app.gxy = w;
           
           v = v(x,y);
           w = w(x,y);
           
           %% Si se introducen numeros hay que reshapear la matriz a 20x20
           
           if length(v) == 1
               v = v*ones(20);
           end
           
           if length(w) == 1
               w = w*ones(20);
           end
          
            
           
           quiver(x, y, v, w, 1, 'Color', [0.5 0.5 0.5]);
           
           
           
           
           % Dibujar la trayectoria aproximada
           
           % Reemplazar los nombres de las funciones por x(1) y x(2)
           xpstr = replace(xpstr, 'x', 'x(1)');
           xpstr = replace(xpstr, 'y', 'x(2)');
           ypstr = replace(ypstr, 'x', 'x(1)');
           ypstr = replace(ypstr, 'y', 'x(2)');
           
           % Parámetros para calcular la solución
           fun = @(t, x) [eval(xpstr); eval(ypstr)]; %Funcion anónima 
           fun_bw = @(t, x) -[eval(xpstr); eval(ypstr)];
           
           try x0 = ginput(1);  catch
           end
            %tinic = 0; 
            %tfin = app.LongituddelintervaloEditField.Value; 
            %N = app.PuntosEditField.Value;
            %h = (tfin - tinic) / N;
           
           try
               while 1
                   tinic = 0; 
                   tfin = app.LongituddelintervaloEditField.Value; 
                   N = app.PuntosEditField.Value;
                   figure(1)
                   hold on;
                   if app.AdelanteButton.Value == 1 || app.AdelanteyatrsButton.Value == 1
                       % Aplicar el método numérico
                       t_fw = linspace(tinic, tfin, N);
                       [t_fw, u_fw] = app.metodo(fun, t_fw, x0);
                       
                       u_fw = u_fw.';
                       
                       % Pintar la gráfica
                   
                       plot(u_fw(1,:), u_fw(2,:), app.color, 'LineWidth', 1.5);
                       
                   else
                       u_fw = [];
                       t_fw = [];
                   end
                   
                   %Trayectoria hacia atrás                     
                   if app.AtrsButton_2.Value == 1 || app.AdelanteyatrsButton.Value == 1
                       t_bw = linspace(tinic, tfin, N);
                       [t_bw, u_bw] = app.metodo(fun_bw, t_bw, x0);
                           
                       u_bw = u_bw.';
                          
                           
                       plot(u_bw(1,:), u_bw(2,:), app.color, 'LineWidth', 1.5);
                       
                   else
                       u_bw = [];
                       t_bw = [];
                   end
                   
                   t_fw = reshape(t_fw, 1, []);
                   t_bw = reshape(t_bw, 1, []);
                   
                   t = [fliplr(-t_bw) t_fw];
                   
                   u = [fliplr(u_bw) u_fw];
                   
                   
                   
                   %Pintar componentes
                   figure(2)
                   clf;
                   subplot(2,1,1);
                   plot(t, u(1,:), app.color);
                   title("x(t)")
                   subplot(2,1,2);
                   plot(t, u(2,:), app.color);
                   title("y(t)");
                   
                   % Pedir otro punto inicial
                   figure(1);
                 
                   x0 = ginput(1);
                
               end 
           catch 
           end
          
        end

        % Menu selected function: VanDerPolMenu
        function VanDerPolMenuSelected(app, event)
            app.EditFieldX.Value = "y";
            app.EditFieldY.Value = "-(x^2-1)*y - x";
        end

        % Menu selected function: MtododeEulerMenu
        function MtododeEulerMenuSelected(app, event)
            app.metodo = @euler;
            app.color = 'b';
        end

        % Menu selected function: RungeKuttaorden4Menu
        function RungeKuttaorden4MenuSelected(app, event)
            app.metodo = @rk4;
            app.color = 'm';
        end

        % Menu selected function: LotkaVolterraMenu
        function LotkaVolterraMenuSelected(app, event)
            app.EditFieldX.Value = "a*x - b*x*y";
            app.EditFieldY.Value = "-c*y + d*x*y";
            % Parámetros
            app.EditFieldP1Name.Value = "a";
            app.EditFieldP1.Value = "0.4";
            app.EditFieldP2Name.Value = "b";
            app.EditFieldP2.Value = "0.01";
            app.EditFieldP3Name.Value = "c";
            app.EditFieldP3.Value = "0.4";
            app.EditFieldP4Name.Value = "d";
            app.EditFieldP4.Value = "0.01";
            
            % Tamaño ventana
            app.MnxEditField.Value = 25;
            app.MxxEditField.Value = 60;
            app.MnyEditField.Value = 25;
            app.MxyEditField.Value = 60;
            
        end

        % Menu selected function: CompeticinMenu
        function CompeticinMenuSelected(app, event)
            app.EditFieldX.Value = "a*x - b*x*y - e*x^2 ";
            app.EditFieldY.Value = "-c*y + d*x*y - f*y^2";
            
            app.EditFieldP1Name.Value = "a";
            app.EditFieldP1.Value = "0.4";
            app.EditFieldP2Name.Value = "b";
            app.EditFieldP2.Value = "0.01";
            app.EditFieldP3Name.Value = "c";
            app.EditFieldP3.Value = "0.4";
            app.EditFieldP4Name.Value = "d";
            app.EditFieldP4.Value = "0.01";
            app.EditFieldP5Name.Value = "e";
            app.EditFieldP5.Value = "0.0";
            app.EditFieldP6Name.Value = "f";
            app.EditFieldP6.Value = "0.0";
            
            
            % Tamaño ventana
            app.MnxEditField.Value = 25;
            app.MxxEditField.Value = 60;
            app.MnyEditField.Value = 25;
            app.MxyEditField.Value = 60;
        end

        % Menu selected function: DuffingMenu
        function DuffingMenuSelected(app, event)
            app.EditFieldX.Value = "y";
            app.EditFieldY.Value = "-x^3+x";
        end

        % Button pushed function: SalirButton
        function ResetSalirButtonPushed(app, event)
            close all;
            delete(app);
        end

        % Button pushed function: AtrsButton
        function AtrsButtonPushed(app, event)
            close all;
            TFG;
            delete(app);
        end

        % Callback function
        function ClearButtonPushed(app, event)
            figure(1);
            clf;
            figure(2);
            clf;
        end

        % Menu selected function: ode45Menu
        function ode45MenuSelected(app, event)
            app.metodo = @ode45;
            app.color = 'g';
        end

        % Menu selected function: ode23Menu
        function ode23MenuSelected(app, event)
            app.metodo = @ode23;
            app.color = 'g';
        end

        % Menu selected function: ode113Menu
        function ode113MenuSelected(app, event)
            app.metodo = @ode113;
            app.color = 'g';
        end

        % Menu selected function: ode15sMenu
        function ode15sMenuSelected(app, event)
            app.metodo = @ode15s;
            app.color = 'g';
        end

        % Menu selected function: ode23sMenu
        function ode23sMenuSelected(app, event)
            app.metodo = @ode23s;
            app.color = 'g';
        end

        % Menu selected function: ode23tMenu
        function ode23tMenuSelected(app, event)
            app.metodo = @ode23t;
            app.color = 'g';
        end

        % Menu selected function: ode23tbMenu
        function ode23tbMenuSelected(app, event)
            app.metodo = @ode23tb;
            app.color = 'g';
        end

        % Menu selected function: PnduloMenu
        function PnduloMenuSelected(app, event)
            app.EditFieldX.Value = "y";
            app.EditFieldY.Value = "-sin(x)-d*y";
            app.EditFieldP1Name.Value = "d";
            app.EditFieldP1.Value = "0";
        end

        % Menu selected function: IsoclinasMenu
        function IsoclinasMenuSelected(app, event)
            figure(1);
            fimplicit(app.fxy, [app.MnxEditField.Value app.MxxEditField.Value]);
            fimplicit(app.gxy, [app.MnxEditField.Value app.MxxEditField.Value]);
        end

        % Menu selected function: AdamsBashforthorden4Menu
        function AdamsBashforthorden4MenuSelected(app, event)
            app.metodo = @ab4;
            app.color = 'r';
        end

        % Menu selected function: DiferenciascentradasMenu
        function DiferenciascentradasMenuSelected(app, event)
            app.metodo = @dif_cent;
            app.color = 'c';
        end

        % Menu selected function: Nystrmorden4Menu
        function Nystrmorden4MenuSelected(app, event)
            app.metodo = @nys4;
            app.color = 'k';
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 737 597];
            app.UIFigure.Name = 'UI Figure';

            % Create GaleraMenu
            app.GaleraMenu = uimenu(app.UIFigure);
            app.GaleraMenu.Text = 'Galería';

            % Create VanDerPolMenu
            app.VanDerPolMenu = uimenu(app.GaleraMenu);
            app.VanDerPolMenu.MenuSelectedFcn = createCallbackFcn(app, @VanDerPolMenuSelected, true);
            app.VanDerPolMenu.Text = 'VanDerPol';

            % Create LotkaVolterraMenu
            app.LotkaVolterraMenu = uimenu(app.GaleraMenu);
            app.LotkaVolterraMenu.MenuSelectedFcn = createCallbackFcn(app, @LotkaVolterraMenuSelected, true);
            app.LotkaVolterraMenu.Text = 'Lotka-Volterra';

            % Create CompeticinMenu
            app.CompeticinMenu = uimenu(app.GaleraMenu);
            app.CompeticinMenu.MenuSelectedFcn = createCallbackFcn(app, @CompeticinMenuSelected, true);
            app.CompeticinMenu.Text = 'Competición';

            % Create DuffingMenu
            app.DuffingMenu = uimenu(app.GaleraMenu);
            app.DuffingMenu.MenuSelectedFcn = createCallbackFcn(app, @DuffingMenuSelected, true);
            app.DuffingMenu.Text = 'Duffing';

            % Create PnduloMenu
            app.PnduloMenu = uimenu(app.GaleraMenu);
            app.PnduloMenu.MenuSelectedFcn = createCallbackFcn(app, @PnduloMenuSelected, true);
            app.PnduloMenu.Text = 'Péndulo';

            % Create MtodosMenu
            app.MtodosMenu = uimenu(app.UIFigure);
            app.MtodosMenu.Text = 'Métodos';

            % Create MtododeEulerMenu
            app.MtododeEulerMenu = uimenu(app.MtodosMenu);
            app.MtododeEulerMenu.MenuSelectedFcn = createCallbackFcn(app, @MtododeEulerMenuSelected, true);
            app.MtododeEulerMenu.Text = 'Método de Euler';

            % Create DiferenciascentradasMenu
            app.DiferenciascentradasMenu = uimenu(app.MtodosMenu);
            app.DiferenciascentradasMenu.MenuSelectedFcn = createCallbackFcn(app, @DiferenciascentradasMenuSelected, true);
            app.DiferenciascentradasMenu.Text = 'Diferencias centradas';

            % Create RungeKuttaorden4Menu
            app.RungeKuttaorden4Menu = uimenu(app.MtodosMenu);
            app.RungeKuttaorden4Menu.MenuSelectedFcn = createCallbackFcn(app, @RungeKuttaorden4MenuSelected, true);
            app.RungeKuttaorden4Menu.Text = 'Runge-Kutta orden 4';

            % Create AdamsBashforthorden4Menu
            app.AdamsBashforthorden4Menu = uimenu(app.MtodosMenu);
            app.AdamsBashforthorden4Menu.MenuSelectedFcn = createCallbackFcn(app, @AdamsBashforthorden4MenuSelected, true);
            app.AdamsBashforthorden4Menu.Text = 'Adams-Bashforth orden 4';

            % Create Nystrmorden4Menu
            app.Nystrmorden4Menu = uimenu(app.MtodosMenu);
            app.Nystrmorden4Menu.MenuSelectedFcn = createCallbackFcn(app, @Nystrmorden4MenuSelected, true);
            app.Nystrmorden4Menu.Text = 'Nyström orden 4';

            % Create ode45Menu
            app.ode45Menu = uimenu(app.MtodosMenu);
            app.ode45Menu.MenuSelectedFcn = createCallbackFcn(app, @ode45MenuSelected, true);
            app.ode45Menu.Separator = 'on';
            app.ode45Menu.Text = 'ode45';

            % Create ode23Menu
            app.ode23Menu = uimenu(app.MtodosMenu);
            app.ode23Menu.MenuSelectedFcn = createCallbackFcn(app, @ode23MenuSelected, true);
            app.ode23Menu.Text = 'ode23';

            % Create ode113Menu
            app.ode113Menu = uimenu(app.MtodosMenu);
            app.ode113Menu.MenuSelectedFcn = createCallbackFcn(app, @ode113MenuSelected, true);
            app.ode113Menu.Text = 'ode113';

            % Create ode15sMenu
            app.ode15sMenu = uimenu(app.MtodosMenu);
            app.ode15sMenu.MenuSelectedFcn = createCallbackFcn(app, @ode15sMenuSelected, true);
            app.ode15sMenu.Text = 'ode15s';

            % Create ode23sMenu
            app.ode23sMenu = uimenu(app.MtodosMenu);
            app.ode23sMenu.MenuSelectedFcn = createCallbackFcn(app, @ode23sMenuSelected, true);
            app.ode23sMenu.Text = 'ode23s';

            % Create ode23tMenu
            app.ode23tMenu = uimenu(app.MtodosMenu);
            app.ode23tMenu.MenuSelectedFcn = createCallbackFcn(app, @ode23tMenuSelected, true);
            app.ode23tMenu.Text = 'ode23t';

            % Create ode23tbMenu
            app.ode23tbMenu = uimenu(app.MtodosMenu);
            app.ode23tbMenu.MenuSelectedFcn = createCallbackFcn(app, @ode23tbMenuSelected, true);
            app.ode23tbMenu.Text = 'ode23tb';

            % Create OpcionesMenu
            app.OpcionesMenu = uimenu(app.UIFigure);
            app.OpcionesMenu.Text = 'Opciones';

            % Create IsoclinasMenu
            app.IsoclinasMenu = uimenu(app.OpcionesMenu);
            app.IsoclinasMenu.MenuSelectedFcn = createCallbackFcn(app, @IsoclinasMenuSelected, true);
            app.IsoclinasMenu.Text = 'Isoclinas';

            % Create EcuacionesPanel
            app.EcuacionesPanel = uipanel(app.UIFigure);
            app.EcuacionesPanel.Title = 'Ecuaciones';
            app.EcuacionesPanel.FontSize = 14;
            app.EcuacionesPanel.Position = [39 416 363 162];

            % Create EditFieldX
            app.EditFieldX = uieditfield(app.EcuacionesPanel, 'text');
            app.EditFieldX.FontSize = 14;
            app.EditFieldX.Position = [75 97 264 22];
            app.EditFieldX.Value = '2*x - y + 3*(x^2-y^2) + 2*x*y';

            % Create EditFieldY
            app.EditFieldY = uieditfield(app.EcuacionesPanel, 'text');
            app.EditFieldY.FontSize = 14;
            app.EditFieldY.Position = [75 44 264 22];
            app.EditFieldY.Value = ' x - 3*y - 3*(x^2-y^2) + 3*x*y';

            % Create Label
            app.Label = uilabel(app.EcuacionesPanel);
            app.Label.FontSize = 14;
            app.Label.Position = [42 97 25 22];
            app.Label.Text = '''  =';

            % Create Label_2
            app.Label_2 = uilabel(app.EcuacionesPanel);
            app.Label_2.FontSize = 14;
            app.Label_2.Position = [42 44 25 22];
            app.Label_2.Text = '''  =';

            % Create xLabel
            app.xLabel = uilabel(app.EcuacionesPanel);
            app.xLabel.HorizontalAlignment = 'right';
            app.xLabel.FontSize = 14;
            app.xLabel.Position = [1 97 33 22];
            app.xLabel.Text = 'x';

            % Create yLabel
            app.yLabel = uilabel(app.EcuacionesPanel);
            app.yLabel.HorizontalAlignment = 'right';
            app.yLabel.FontSize = 14;
            app.yLabel.Position = [1 44 33 22];
            app.yLabel.Text = 'y';

            % Create VamosButton
            app.VamosButton = uibutton(app.UIFigure, 'push');
            app.VamosButton.ButtonPushedFcn = createCallbackFcn(app, @VamosButtonPushed, true);
            app.VamosButton.FontSize = 14;
            app.VamosButton.Tooltip = {'Establece las figuras según las ecuaciones'; ' los parámetros y el tamaño indicados'};
            app.VamosButton.Position = [577 35 122 26];
            app.VamosButton.Text = '¡Vamos!';

            % Create AtrsButton
            app.AtrsButton = uibutton(app.UIFigure, 'push');
            app.AtrsButton.ButtonPushedFcn = createCallbackFcn(app, @AtrsButtonPushed, true);
            app.AtrsButton.FontSize = 14;
            app.AtrsButton.Tooltip = {'Volver al menú de dimensiones'};
            app.AtrsButton.Position = [39 35 122 26];
            app.AtrsButton.Text = 'Atrás';

            % Create ParmetrosPanel
            app.ParmetrosPanel = uipanel(app.UIFigure);
            app.ParmetrosPanel.Title = 'Parámetros';
            app.ParmetrosPanel.FontSize = 14;
            app.ParmetrosPanel.Position = [423 235 276 343];

            % Create EditFieldP1Name
            app.EditFieldP1Name = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP1Name.FontSize = 14;
            app.EditFieldP1Name.Position = [33 278 48 22];

            % Create EditFieldP1
            app.EditFieldP1 = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP1.FontSize = 14;
            app.EditFieldP1.Position = [133 278 48 22];

            % Create EditFieldP2Name
            app.EditFieldP2Name = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP2Name.FontSize = 14;
            app.EditFieldP2Name.Position = [33 232 48 22];

            % Create EditFieldP2
            app.EditFieldP2 = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP2.FontSize = 14;
            app.EditFieldP2.Position = [133 232 48 22];

            % Create EditFieldP3Name
            app.EditFieldP3Name = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP3Name.FontSize = 14;
            app.EditFieldP3Name.Position = [33 186 48 22];

            % Create EditFieldP3
            app.EditFieldP3 = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP3.FontSize = 14;
            app.EditFieldP3.Position = [133 186 48 22];

            % Create EditFieldP4Name
            app.EditFieldP4Name = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP4Name.FontSize = 14;
            app.EditFieldP4Name.Position = [33 140 48 22];

            % Create EditFieldP4
            app.EditFieldP4 = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP4.FontSize = 14;
            app.EditFieldP4.Position = [133 140 48 22];

            % Create Label_3
            app.Label_3 = uilabel(app.ParmetrosPanel);
            app.Label_3.HorizontalAlignment = 'center';
            app.Label_3.FontSize = 14;
            app.Label_3.Position = [94 278 25 22];
            app.Label_3.Text = ' =';

            % Create Label_4
            app.Label_4 = uilabel(app.ParmetrosPanel);
            app.Label_4.HorizontalAlignment = 'center';
            app.Label_4.FontSize = 14;
            app.Label_4.Position = [94 236 25 22];
            app.Label_4.Text = ' =';

            % Create Label_5
            app.Label_5 = uilabel(app.ParmetrosPanel);
            app.Label_5.HorizontalAlignment = 'center';
            app.Label_5.FontSize = 14;
            app.Label_5.Position = [94 186 25 22];
            app.Label_5.Text = ' =';

            % Create Label_6
            app.Label_6 = uilabel(app.ParmetrosPanel);
            app.Label_6.HorizontalAlignment = 'center';
            app.Label_6.FontSize = 14;
            app.Label_6.Position = [94 140 25 22];
            app.Label_6.Text = ' =';

            % Create Label_7
            app.Label_7 = uilabel(app.ParmetrosPanel);
            app.Label_7.HorizontalAlignment = 'center';
            app.Label_7.FontSize = 14;
            app.Label_7.Position = [94 49 25 22];
            app.Label_7.Text = ' =';

            % Create EditFieldP6Name
            app.EditFieldP6Name = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP6Name.FontSize = 14;
            app.EditFieldP6Name.Position = [33 49 48 22];

            % Create EditFieldP6
            app.EditFieldP6 = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP6.FontSize = 14;
            app.EditFieldP6.Position = [133 49 48 22];

            % Create Label_8
            app.Label_8 = uilabel(app.ParmetrosPanel);
            app.Label_8.HorizontalAlignment = 'center';
            app.Label_8.FontSize = 14;
            app.Label_8.Position = [94 94 25 22];
            app.Label_8.Text = ' =';

            % Create EditFieldP5Name
            app.EditFieldP5Name = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP5Name.FontSize = 14;
            app.EditFieldP5Name.Position = [33 94 48 22];

            % Create EditFieldP5
            app.EditFieldP5 = uieditfield(app.ParmetrosPanel, 'text');
            app.EditFieldP5.FontSize = 14;
            app.EditFieldP5.Position = [133 94 48 22];

            % Create TamaodelaventanaPanel
            app.TamaodelaventanaPanel = uipanel(app.UIFigure);
            app.TamaodelaventanaPanel.Title = 'Tamaño de la ventana';
            app.TamaodelaventanaPanel.FontSize = 14;
            app.TamaodelaventanaPanel.Position = [39 235 363 162];

            % Create MnxEditFieldLabel
            app.MnxEditFieldLabel = uilabel(app.TamaodelaventanaPanel);
            app.MnxEditFieldLabel.HorizontalAlignment = 'right';
            app.MnxEditFieldLabel.FontSize = 14;
            app.MnxEditFieldLabel.Position = [17 91 39 22];
            app.MnxEditFieldLabel.Text = 'Mín x';

            % Create MnxEditField
            app.MnxEditField = uieditfield(app.TamaodelaventanaPanel, 'numeric');
            app.MnxEditField.FontSize = 14;
            app.MnxEditField.Tooltip = {'Límite por la izquierda'};
            app.MnxEditField.Position = [71 91 100 22];
            app.MnxEditField.Value = -4;

            % Create MxxEditFieldLabel
            app.MxxEditFieldLabel = uilabel(app.TamaodelaventanaPanel);
            app.MxxEditFieldLabel.HorizontalAlignment = 'right';
            app.MxxEditFieldLabel.FontSize = 14;
            app.MxxEditFieldLabel.Position = [17 43 43 22];
            app.MxxEditFieldLabel.Text = 'Máx x';

            % Create MxxEditField
            app.MxxEditField = uieditfield(app.TamaodelaventanaPanel, 'numeric');
            app.MxxEditField.FontSize = 14;
            app.MxxEditField.Tooltip = {'Límite por la derecha'};
            app.MxxEditField.Position = [71 43 100 22];
            app.MxxEditField.Value = 4;

            % Create MnyEditFieldLabel
            app.MnyEditFieldLabel = uilabel(app.TamaodelaventanaPanel);
            app.MnyEditFieldLabel.HorizontalAlignment = 'right';
            app.MnyEditFieldLabel.FontSize = 14;
            app.MnyEditFieldLabel.Position = [195 91 39 22];
            app.MnyEditFieldLabel.Text = 'Mín y';

            % Create MnyEditField
            app.MnyEditField = uieditfield(app.TamaodelaventanaPanel, 'numeric');
            app.MnyEditField.FontSize = 14;
            app.MnyEditField.Tooltip = {'Límite por abajo'};
            app.MnyEditField.Position = [249 91 100 22];
            app.MnyEditField.Value = -4;

            % Create MxyEditFieldLabel
            app.MxyEditFieldLabel = uilabel(app.TamaodelaventanaPanel);
            app.MxyEditFieldLabel.HorizontalAlignment = 'right';
            app.MxyEditFieldLabel.FontSize = 14;
            app.MxyEditFieldLabel.Position = [195 43 43 22];
            app.MxyEditFieldLabel.Text = 'Máx y';

            % Create MxyEditField
            app.MxyEditField = uieditfield(app.TamaodelaventanaPanel, 'numeric');
            app.MxyEditField.FontSize = 14;
            app.MxyEditField.Tooltip = {'Límite por arriba'};
            app.MxyEditField.Position = [249 43 100 22];
            app.MxyEditField.Value = 4;

            % Create OtrosdatosPanel
            app.OtrosdatosPanel = uipanel(app.UIFigure);
            app.OtrosdatosPanel.Title = 'Otros datos';
            app.OtrosdatosPanel.FontSize = 14;
            app.OtrosdatosPanel.Position = [423 83 276 131];

            % Create LongituddelintervaloEditFieldLabel
            app.LongituddelintervaloEditFieldLabel = uilabel(app.OtrosdatosPanel);
            app.LongituddelintervaloEditFieldLabel.HorizontalAlignment = 'right';
            app.LongituddelintervaloEditFieldLabel.FontSize = 14;
            app.LongituddelintervaloEditFieldLabel.Position = [12 66 139 22];
            app.LongituddelintervaloEditFieldLabel.Text = 'Longitud del intervalo';

            % Create LongituddelintervaloEditField
            app.LongituddelintervaloEditField = uieditfield(app.OtrosdatosPanel, 'numeric');
            app.LongituddelintervaloEditField.FontSize = 14;
            app.LongituddelintervaloEditField.Tooltip = {'Longitud del intervalo en cada una de las direcciones'};
            app.LongituddelintervaloEditField.Position = [174 66 55 22];
            app.LongituddelintervaloEditField.Value = 100;

            % Create PuntosEditFieldLabel
            app.PuntosEditFieldLabel = uilabel(app.OtrosdatosPanel);
            app.PuntosEditFieldLabel.HorizontalAlignment = 'right';
            app.PuntosEditFieldLabel.FontSize = 14;
            app.PuntosEditFieldLabel.Position = [16 19 49 22];
            app.PuntosEditFieldLabel.Text = 'Puntos';

            % Create PuntosEditField
            app.PuntosEditField = uieditfield(app.OtrosdatosPanel, 'numeric');
            app.PuntosEditField.FontSize = 14;
            app.PuntosEditField.Tooltip = {'Número de puntos sobre los que se van a realizar los cálculos'};
            app.PuntosEditField.Position = [174 19 55 22];
            app.PuntosEditField.Value = 5000;

            % Create SalirButton
            app.SalirButton = uibutton(app.UIFigure, 'push');
            app.SalirButton.ButtonPushedFcn = createCallbackFcn(app, @ResetSalirButtonPushed, true);
            app.SalirButton.FontSize = 14;
            app.SalirButton.Tooltip = {'Cerrar la aplicación'};
            app.SalirButton.Position = [311 35 122 26];
            app.SalirButton.Text = 'Salir';

            % Create TrayectoriasButtonGroup
            app.TrayectoriasButtonGroup = uibuttongroup(app.UIFigure);
            app.TrayectoriasButtonGroup.Title = 'Trayectorias';
            app.TrayectoriasButtonGroup.FontSize = 14;
            app.TrayectoriasButtonGroup.Position = [39 83 363 131];

            % Create AdelanteButton
            app.AdelanteButton = uiradiobutton(app.TrayectoriasButtonGroup);
            app.AdelanteButton.Tooltip = {'Dibujar las trayectorias sólo hacia adelante'};
            app.AdelanteButton.Text = 'Adelante';
            app.AdelanteButton.FontSize = 14;
            app.AdelanteButton.Position = [18 76 77 22];

            % Create AtrsButton_2
            app.AtrsButton_2 = uiradiobutton(app.TrayectoriasButtonGroup);
            app.AtrsButton_2.Tooltip = {'Dibujar las trayectorias sólo hacia atrás'};
            app.AtrsButton_2.Text = 'Atrás';
            app.AtrsButton_2.FontSize = 14;
            app.AtrsButton_2.Position = [18 44 65 22];

            % Create AdelanteyatrsButton
            app.AdelanteyatrsButton = uiradiobutton(app.TrayectoriasButtonGroup);
            app.AdelanteyatrsButton.Tooltip = {'Dibujar las trayectorias hacia adelante y hacia atrás'};
            app.AdelanteyatrsButton.Text = 'Adelante y atrás';
            app.AdelanteyatrsButton.FontSize = 14;
            app.AdelanteyatrsButton.Position = [18 12 123 22];
            app.AdelanteyatrsButton.Value = true;
        end
    end

    methods (Access = public)

        % Construct app
        function app = D2

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end