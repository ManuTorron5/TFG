classdef D3 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                  matlab.ui.Figure
        GaleraMenu                matlab.ui.container.Menu
        LorenzMenu                matlab.ui.container.Menu
        BelusovZhabotinskyMenu    matlab.ui.container.Menu
        CoraznMenu                matlab.ui.container.Menu
        DuffingforzadoMenu        matlab.ui.container.Menu
        MtodosMenu                matlab.ui.container.Menu
        MtododeEulerMenu          matlab.ui.container.Menu
        DiferenciascentradasMenu  matlab.ui.container.Menu
        RungeKuttaorden4Menu      matlab.ui.container.Menu
        AdamsBashforthorden4Menu  matlab.ui.container.Menu
        Nystrmorden4Menu          matlab.ui.container.Menu
        ode45Menu                 matlab.ui.container.Menu
        ode23Menu                 matlab.ui.container.Menu
        ode113Menu                matlab.ui.container.Menu
        ode15sMenu                matlab.ui.container.Menu
        ode23sMenu                matlab.ui.container.Menu
        ode23tMenu                matlab.ui.container.Menu
        ode23tbMenu               matlab.ui.container.Menu
        OpcionesMenu              matlab.ui.container.Menu
        IsoclinasMenu             matlab.ui.container.Menu
        EcuacionesPanel           matlab.ui.container.Panel
        EditFieldX                matlab.ui.control.EditField
        EditFieldY                matlab.ui.control.EditField
        Label                     matlab.ui.control.Label
        Label_2                   matlab.ui.control.Label
        xLabel                    matlab.ui.control.Label
        yLabel                    matlab.ui.control.Label
        EditFieldZ                matlab.ui.control.EditField
        Label_7                   matlab.ui.control.Label
        zLabel                    matlab.ui.control.Label
        VamosButton               matlab.ui.control.Button
        AtrsButton                matlab.ui.control.Button
        PuntoinicialPanel         matlab.ui.container.Panel
        x0EditFieldLabel          matlab.ui.control.Label
        EditFieldx0               matlab.ui.control.NumericEditField
        Label_8                   matlab.ui.control.Label
        Label_9                   matlab.ui.control.Label
        y0EditFieldLabel          matlab.ui.control.Label
        EditFieldy0               matlab.ui.control.NumericEditField
        Label_10                  matlab.ui.control.Label
        z0EditFieldLabel          matlab.ui.control.Label
        EditFieldz0               matlab.ui.control.NumericEditField
        OtrosdatosPanel           matlab.ui.container.Panel
        InicioEditFieldLabel      matlab.ui.control.Label
        InicioEditField           matlab.ui.control.NumericEditField
        FinEditFieldLabel         matlab.ui.control.Label
        FinEditField              matlab.ui.control.NumericEditField
        PuntosEditFieldLabel      matlab.ui.control.Label
        PuntosEditField           matlab.ui.control.NumericEditField
        SalirButton               matlab.ui.control.Button
    end

    
    properties (Access = private)
        metodo = @rk4; % Método a utilizar
        color = 'm'; % Color para pintar la trayectoria (en principio depende del método usado)
        fxyz = 0; % Función simbólica de x'
        gxyz = 0; % Función simbólica de y'
        hxyz = 0; % Función simbólica de z' %3D%
    end
    
  
    

    methods (Access = private)

        % Button pushed function: VamosButton
        function VamosButtonPushed(app, event)
           % Despajamos todas las figuras
           figure(1);
           clf;
           figure(2);
           clf;
           figure(3)
           clf;
            
           xpstr = app.EditFieldX.Value;
           ypstr = app.EditFieldY.Value;
           zpstr = app.EditFieldZ.Value; %3D
         
           
           % Reemplazar nombre de los parámetros por valor de los parámetros
%            xpstr = replace(xpstr, app.EditFieldP1Name.Value, app.EditFieldP1.Value);
%            xpstr = replace(xpstr, app.EditFieldP2Name.Value, app.EditFieldy0.Value);
%            xpstr = replace(xpstr, app.EditFieldP3Name.Value, app.EditFieldz0.Value);
%            xpstr = replace(xpstr, app.EditFieldP4Name.Value, app.EditFieldP4.Value);
%            ypstr = replace(ypstr, app.EditFieldP1Name.Value, app.EditFieldP1.Value);
%            ypstr = replace(ypstr, app.EditFieldP2Name.Value, app.EditFieldy0.Value);
%            ypstr = replace(ypstr, app.EditFieldP3Name.Value, app.EditFieldz0.Value);
%            ypstr = replace(ypstr, app.EditFieldP4Name.Value, app.EditFieldP4.Value);
           
           xaux = xpstr;
           yaux = ypstr; 
           zaux = zpstr;
           
           % Abrimos una figura si antes no existía
          
           figure(1);
           
           % Formato de la figure
           %hold on;
           grid on;
           %grid minor;
           
           
           % Funciones anonimas elemento a elemento
           
           % Funciones elemento a elemento
           xaux = replace(xaux, "*", ".*");
           xaux = replace(xaux, "^", ".^");
           xaux = replace(xaux, "/", "./");
           
           yaux = replace(yaux, "*", ".*");
           yaux = replace(yaux, "^", ".^");
           yaux = replace(yaux, "/", "./");
           
           zaux = replace(zaux, "*", ".*"); %3D
           zaux = replace(zaux, "^", ".^"); %3D
           zaux = replace(zaux, "/", "./"); %3D
                     
   
           v = @(x, y, z) eval(xaux); %3D
           w = @(x, y, z) eval(yaux); %3D
           ww = @(x, y, z) eval(zaux);
           
           
           app.fxyz = v; %3D
           app.gxyz = w; %3D
           app.hxyz = ww; %3D
           
        
           
           
           % Dibujar la trayectoria aproximada
           
           % Reemplazar los nombres de las funciones por x(1) y x(2)
           xpstr = replace(xpstr, 'x', 'x(1)');
           xpstr = replace(xpstr, 'y', 'x(2)');
           xpstr = replace(xpstr, 'z', 'x(3)');
           ypstr = replace(ypstr, 'x', 'x(1)');
           ypstr = replace(ypstr, 'y', 'x(2)');
           ypstr = replace(ypstr, 'z', 'x(3)');
           zpstr = replace(zpstr, 'x', 'x(1)');
           zpstr = replace(zpstr, 'y', 'x(2)');
           zpstr = replace(zpstr, 'z', 'x(3)');
           
           % Parámetros para calcular la solución
           fun = @(t, x) [eval(xpstr); eval(ypstr); eval(zpstr)]; %Funcion anónima 


           x0 = [app.EditFieldx0.Value, app.EditFieldy0.Value, app.EditFieldz0.Value];
           tinic = app.InicioEditField.Value; 
           tfin = app.FinEditField.Value; 
           N = app.PuntosEditField.Value;
           % h = (tfin - tinic) / N;
           
          
           % Aplicar el método numérico
           t = linspace(tinic, tfin, N);
           [t,u] = app.metodo(fun, t, x0);
           
           u = u.';
           
           figure(1)
           grid on;
           % Pintar la gráfica
           plot3(u(1,:), u(2,:), u(3,:), app.color);
           
           %Pintar componentes
           figure(2)
           subplot(3,1,1);
           plot(t, u(1,:), app.color);
           title("x(t)")
           subplot(3,1,2);
           plot(t, u(2,:), app.color);
           title("y(t)");
           subplot(3,1,3);
           plot(t, u(3,:), app.color);
           title("z(t)");
                   
          
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

        % Menu selected function: IsoclinasMenu
        function IsoclinasMenuSelected(app, event)
            figure(3);
            hold on;
            fimplicit3(app.fxyz);
            fimplicit3(app.gxyz);
            fimplicit3(app.hxyz);
        end

        % Menu selected function: AdamsBashforthorden4Menu
        function AdamsBashforthorden4MenuSelected(app, event)
            app.metodo = @ab4;
            app.color = 'r';
        end

        % Menu selected function: LorenzMenu
        function LorenzMenuSelected(app, event)
            app.EditFieldX.Value = "10*(y - x)";
            app.EditFieldY.Value = "28*x - y - x*z";
            app.EditFieldZ.Value = "x*y - (8/3)*z";
            app.EditFieldx0.Value = 0;
            app.EditFieldy0.Value = 2;
            app.EditFieldz0.Value = 0;          
        end

        % Menu selected function: BelusovZhabotinskyMenu
        function BelusovZhabotinskyMenuSelected(app, event)
            app.EditFieldX.Value = "2000*(y-x*y+x-0.0008*x^2)";
            app.EditFieldY.Value = "1/2000*(5000*z-y-x*y)";
            app.EditFieldZ.Value = "0.75*(x-z)";
            app.EditFieldx0.Value = 0.25;
            app.EditFieldy0.Value = 0.75;
            app.EditFieldz0.Value = 0.25;  
        end

        % Menu selected function: CoraznMenu
        function CoraznMenuSelected(app, event)
            app.EditFieldX.Value = "y";
            app.EditFieldY.Value = "-16*x+4*sin(2*z)";
            app.EditFieldZ.Value = "1";
            app.EditFieldx0.Value = 0;
            app.EditFieldy0.Value = 2;
            app.EditFieldz0.Value = 0; 
        end

        % Menu selected function: DuffingforzadoMenu
        function DuffingforzadoMenuSelected(app, event)
            app.EditFieldX.Value = "y";
            app.EditFieldY.Value = "-0.25*y+x-x^3+0.25*cos(z)";
            app.EditFieldZ.Value = "1";
            app.EditFieldx0.Value = 0.2;
            app.EditFieldy0.Value = 0.1;
            app.EditFieldz0.Value = 0; 
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
            app.UIFigure.Position = [100 100 735 526];
            app.UIFigure.Name = 'UI Figure';

            % Create GaleraMenu
            app.GaleraMenu = uimenu(app.UIFigure);
            app.GaleraMenu.Text = 'Galería';

            % Create LorenzMenu
            app.LorenzMenu = uimenu(app.GaleraMenu);
            app.LorenzMenu.MenuSelectedFcn = createCallbackFcn(app, @LorenzMenuSelected, true);
            app.LorenzMenu.Text = 'Lorenz';

            % Create BelusovZhabotinskyMenu
            app.BelusovZhabotinskyMenu = uimenu(app.GaleraMenu);
            app.BelusovZhabotinskyMenu.MenuSelectedFcn = createCallbackFcn(app, @BelusovZhabotinskyMenuSelected, true);
            app.BelusovZhabotinskyMenu.Text = 'Belusov-Zhabotinsky';

            % Create CoraznMenu
            app.CoraznMenu = uimenu(app.GaleraMenu);
            app.CoraznMenu.MenuSelectedFcn = createCallbackFcn(app, @CoraznMenuSelected, true);
            app.CoraznMenu.Text = 'Corazón';

            % Create DuffingforzadoMenu
            app.DuffingforzadoMenu = uimenu(app.GaleraMenu);
            app.DuffingforzadoMenu.MenuSelectedFcn = createCallbackFcn(app, @DuffingforzadoMenuSelected, true);
            app.DuffingforzadoMenu.Text = 'Duffing forzado';

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
            app.EcuacionesPanel.Position = [39 265 363 226];

            % Create EditFieldX
            app.EditFieldX = uieditfield(app.EcuacionesPanel, 'text');
            app.EditFieldX.FontSize = 14;
            app.EditFieldX.Position = [75 161 264 22];
            app.EditFieldX.Value = '2*x - y + 3*(x^2-y^2) + 2*x*y';

            % Create EditFieldY
            app.EditFieldY = uieditfield(app.EcuacionesPanel, 'text');
            app.EditFieldY.FontSize = 14;
            app.EditFieldY.Position = [75 103 264 22];
            app.EditFieldY.Value = ' x - 3*y - 3*(x^2-y^2) + 3*x*y';

            % Create Label
            app.Label = uilabel(app.EcuacionesPanel);
            app.Label.FontSize = 14;
            app.Label.Position = [42 161 25 22];
            app.Label.Text = '''  =';

            % Create Label_2
            app.Label_2 = uilabel(app.EcuacionesPanel);
            app.Label_2.FontSize = 14;
            app.Label_2.Position = [42 103 25 22];
            app.Label_2.Text = '''  =';

            % Create xLabel
            app.xLabel = uilabel(app.EcuacionesPanel);
            app.xLabel.HorizontalAlignment = 'right';
            app.xLabel.FontSize = 14;
            app.xLabel.Position = [1 161 33 22];
            app.xLabel.Text = 'x';

            % Create yLabel
            app.yLabel = uilabel(app.EcuacionesPanel);
            app.yLabel.HorizontalAlignment = 'right';
            app.yLabel.FontSize = 14;
            app.yLabel.Position = [1 103 33 22];
            app.yLabel.Text = 'y';

            % Create EditFieldZ
            app.EditFieldZ = uieditfield(app.EcuacionesPanel, 'text');
            app.EditFieldZ.FontSize = 14;
            app.EditFieldZ.Position = [75 45 264 22];
            app.EditFieldZ.Value = '0';

            % Create Label_7
            app.Label_7 = uilabel(app.EcuacionesPanel);
            app.Label_7.FontSize = 14;
            app.Label_7.Position = [42 45 25 22];
            app.Label_7.Text = '''  =';

            % Create zLabel
            app.zLabel = uilabel(app.EcuacionesPanel);
            app.zLabel.HorizontalAlignment = 'right';
            app.zLabel.FontSize = 14;
            app.zLabel.Position = [2 45 33 22];
            app.zLabel.Text = 'z';

            % Create VamosButton
            app.VamosButton = uibutton(app.UIFigure, 'push');
            app.VamosButton.ButtonPushedFcn = createCallbackFcn(app, @VamosButtonPushed, true);
            app.VamosButton.FontSize = 14;
            app.VamosButton.Tooltip = {'Establece las figuras según las ecuaciones indicadas'};
            app.VamosButton.Position = [577 43 122 26];
            app.VamosButton.Text = '¡Vamos!';

            % Create AtrsButton
            app.AtrsButton = uibutton(app.UIFigure, 'push');
            app.AtrsButton.ButtonPushedFcn = createCallbackFcn(app, @AtrsButtonPushed, true);
            app.AtrsButton.FontSize = 14;
            app.AtrsButton.Position = [39 43 122 26];
            app.AtrsButton.Text = 'Atrás';

            % Create PuntoinicialPanel
            app.PuntoinicialPanel = uipanel(app.UIFigure);
            app.PuntoinicialPanel.Title = 'Punto inicial';
            app.PuntoinicialPanel.FontSize = 14;
            app.PuntoinicialPanel.Position = [434 265 265 226];

            % Create x0EditFieldLabel
            app.x0EditFieldLabel = uilabel(app.PuntoinicialPanel);
            app.x0EditFieldLabel.HorizontalAlignment = 'right';
            app.x0EditFieldLabel.FontSize = 14;
            app.x0EditFieldLabel.Position = [33 161 25 22];
            app.x0EditFieldLabel.Text = 'x0';

            % Create EditFieldx0
            app.EditFieldx0 = uieditfield(app.PuntoinicialPanel, 'numeric');
            app.EditFieldx0.FontSize = 14;
            app.EditFieldx0.Position = [90 161 84 22];
            app.EditFieldx0.Value = 1;

            % Create Label_8
            app.Label_8 = uilabel(app.PuntoinicialPanel);
            app.Label_8.HorizontalAlignment = 'center';
            app.Label_8.FontSize = 14;
            app.Label_8.Position = [57 161 34 22];
            app.Label_8.Text = '=';

            % Create Label_9
            app.Label_9 = uilabel(app.PuntoinicialPanel);
            app.Label_9.HorizontalAlignment = 'center';
            app.Label_9.FontSize = 14;
            app.Label_9.Position = [57 102 34 22];
            app.Label_9.Text = '=';

            % Create y0EditFieldLabel
            app.y0EditFieldLabel = uilabel(app.PuntoinicialPanel);
            app.y0EditFieldLabel.HorizontalAlignment = 'right';
            app.y0EditFieldLabel.FontSize = 14;
            app.y0EditFieldLabel.Position = [33 103 25 22];
            app.y0EditFieldLabel.Text = 'y0';

            % Create EditFieldy0
            app.EditFieldy0 = uieditfield(app.PuntoinicialPanel, 'numeric');
            app.EditFieldy0.FontSize = 14;
            app.EditFieldy0.Position = [90 103 84 22];
            app.EditFieldy0.Value = -1;

            % Create Label_10
            app.Label_10 = uilabel(app.PuntoinicialPanel);
            app.Label_10.HorizontalAlignment = 'center';
            app.Label_10.FontSize = 14;
            app.Label_10.Position = [57 45 34 22];
            app.Label_10.Text = '=';

            % Create z0EditFieldLabel
            app.z0EditFieldLabel = uilabel(app.PuntoinicialPanel);
            app.z0EditFieldLabel.HorizontalAlignment = 'right';
            app.z0EditFieldLabel.FontSize = 14;
            app.z0EditFieldLabel.Position = [33 45 25 22];
            app.z0EditFieldLabel.Text = 'z0';

            % Create EditFieldz0
            app.EditFieldz0 = uieditfield(app.PuntoinicialPanel, 'numeric');
            app.EditFieldz0.FontSize = 14;
            app.EditFieldz0.Position = [90 45 84 22];

            % Create OtrosdatosPanel
            app.OtrosdatosPanel = uipanel(app.UIFigure);
            app.OtrosdatosPanel.Title = 'Otros datos';
            app.OtrosdatosPanel.FontSize = 14;
            app.OtrosdatosPanel.Position = [39 118 660 111];

            % Create InicioEditFieldLabel
            app.InicioEditFieldLabel = uilabel(app.OtrosdatosPanel);
            app.InicioEditFieldLabel.HorizontalAlignment = 'right';
            app.InicioEditFieldLabel.FontSize = 14;
            app.InicioEditFieldLabel.Position = [37 36 38 22];
            app.InicioEditFieldLabel.Text = 'Inicio';

            % Create InicioEditField
            app.InicioEditField = uieditfield(app.OtrosdatosPanel, 'numeric');
            app.InicioEditField.FontSize = 14;
            app.InicioEditField.Tooltip = {'Inicio del intervalo'};
            app.InicioEditField.Position = [101 36 100 22];

            % Create FinEditFieldLabel
            app.FinEditFieldLabel = uilabel(app.OtrosdatosPanel);
            app.FinEditFieldLabel.HorizontalAlignment = 'right';
            app.FinEditFieldLabel.FontSize = 14;
            app.FinEditFieldLabel.Position = [248 36 25 22];
            app.FinEditFieldLabel.Text = 'Fin';

            % Create FinEditField
            app.FinEditField = uieditfield(app.OtrosdatosPanel, 'numeric');
            app.FinEditField.FontSize = 14;
            app.FinEditField.Tooltip = {'Final del intervalo'};
            app.FinEditField.Position = [312 36 100 22];
            app.FinEditField.Value = 100;

            % Create PuntosEditFieldLabel
            app.PuntosEditFieldLabel = uilabel(app.OtrosdatosPanel);
            app.PuntosEditFieldLabel.HorizontalAlignment = 'right';
            app.PuntosEditFieldLabel.FontSize = 14;
            app.PuntosEditFieldLabel.Position = [446 36 49 22];
            app.PuntosEditFieldLabel.Text = 'Puntos';

            % Create PuntosEditField
            app.PuntosEditField = uieditfield(app.OtrosdatosPanel, 'numeric');
            app.PuntosEditField.FontSize = 14;
            app.PuntosEditField.Tooltip = {'Número de puntos sobre los que se van a realizar los cálculos'};
            app.PuntosEditField.Position = [510 36 100 22];
            app.PuntosEditField.Value = 5000;

            % Create SalirButton
            app.SalirButton = uibutton(app.UIFigure, 'push');
            app.SalirButton.ButtonPushedFcn = createCallbackFcn(app, @ResetSalirButtonPushed, true);
            app.SalirButton.FontSize = 14;
            app.SalirButton.Position = [308 43 122 26];
            app.SalirButton.Text = 'Salir';
        end
    end

    methods (Access = public)

        % Construct app
        function app = D3

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