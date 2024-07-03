def DependencyInjector
    target 'DependencyInjector' do
        # Libs bundled outside
        dependency_injector_pods
    
        target 'DependencyInjectorTests' do
            
        end
    end
end

def NetworkClient
    target 'NetworkClient' do
        # Libs bundled outside
        dependency_injector_pods
    
        target 'NetworkClientTests' do
            
        end
    end
end

def Lightning
    target 'Lightning' do
        # Libs bundled outside
        dependency_injector_pods
    
        target 'LightningTests' do
            
        end
    end
end