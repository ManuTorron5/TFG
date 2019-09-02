classdef TFG < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure             matlab.ui.Figure
        DimensionesButton    matlab.ui.control.Button
        DimensionesButton_2  matlab.ui.control.Button
        SalirButton          matlab.ui.control.Button
    end

    methods (Access = private)

        % Button pushed function: DimensionesButton
        function DimensionesButtonPushed(app, event)
            D2;
            delete(app);
        end

        % Button pushed function: DimensionesButton_2
        function DimensionesButton_2Pushed(app, event)
            D3;
            delete(app);
        end

        % Button pushed function: SalirButton
        function SalirButtonPushed(app, event)
            delete(app);
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 632 318];
            app.UIFigure.Name = 'UI Figure';

            % Create DimensionesButton
            app.DimensionesButton = uibutton(app.UIFigure, 'push');
            app.DimensionesButton.ButtonPushedFcn = createCallbackFcn(app, @DimensionesButtonPushed, true);
            app.DimensionesButton.FontSize = 20;
            app.DimensionesButton.Position = [71 124 192 136];
            app.DimensionesButton.Text = '2 Dimensiones';

            % Create DimensionesButton_2
            app.DimensionesButton_2 = uibutton(app.UIFigure, 'push');
            app.DimensionesButton_2.ButtonPushedFcn = createCallbackFcn(app, @DimensionesButton_2Pushed, true);
            app.DimensionesButton_2.FontSize = 20;
            app.DimensionesButton_2.Position = [360 124 192 136];
            app.DimensionesButton_2.Text = '3 Dimensiones';

            % Create SalirButton
            app.SalirButton = uibutton(app.UIFigure, 'push');
            app.SalirButton.ButtonPushedFcn = createCallbackFcn(app, @SalirButtonPushed, true);
            app.SalirButton.FontSize = 14;
            app.SalirButton.Position = [267 34 100 26];
            app.SalirButton.Text = 'Salir';
        end
    end

    methods (Access = public)

        % Construct app
        function app = TFG

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