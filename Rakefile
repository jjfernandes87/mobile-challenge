import 'scripts/rakefile/Commons.rb'

namespace :libraries do
    task :project do
        sh "cd scripts/spm/automation && open Package.swift"
    end

    task :create do 
        modulePhrase = "1. Selecione o tipo de automação"
        moduleOptions = ["module"]
        moduleStruct = prompt_select(modulePhrase, moduleOptions)

        if moduleStruct === "module"
            createModule(moduleStruct)
        end
    end
end

namespace :xcode do
    task :generate do
        sh "killall Xcode || true"
        sh "xcodegen generate && pod install"
        sh "open Challenge.xcworkspace"
    end
end