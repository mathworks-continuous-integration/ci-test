classdef tinstall < matlab.unittest.TestCase
    properties (TestParameter)
        allowed = {'matlab', 'simulink', 'signal_toolbox', 'statistics_toolbox', ...
            'optimization_toolbox', 'symbolic_toolbox', 'image_toolbox', 'control_toolbox', ...
            'signal_blocks', 'curve_fitting_toolbox'}
        restricted = {'rtw_embedded_coder', 'filter_design_hdl_coder', 'gpu_coder', ...
            'simulink_hdl_coder', 'matlab_coder', 'real-time_workshop', 'simulink_plc_coder'}
    end
    
    methods (Test)
        function testCheckoutAllowedLicense(testCase, allowed)
            [status, msg] = license('checkout', allowed);
            testCase.verifyThat(logical(status), IsTrue, msg);
        end
        
        function testFailToCheckoutRestrictedLicense(testCase, restricted)
            import matlab.unittest.diagnostics.Diagnostic;
            
            [status, msg] = license('checkout', restricted);
            testCase.verifyThat(logical(status), IsFalse, Diagnostic.join([restricted ' should not checkout'], msg));
        end
    end
end

% imports
function c = IsTrue(varargin)
c = matlab.unittest.constraints.IsTrue(varargin{:});
end
function c = IsFalse(varargin)
c = matlab.unittest.constraints.IsFalse(varargin{:});
end