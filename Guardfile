notification :off

group :assets do
  guard 'shell' do
    # css
    watch(/^public\/scss\/(.*)\.s[ac]ss/) do
      puts "compiled CSS" if system('compass compile public')
    end
    
    # coffeescript
    watch(/^public\/coffee\/(.*)\.coffee/) do |m|
      if system("coffee --output public/js/ --compile public/coffee/#{ m[1] }.coffee")
        # note, this depends on Closure Compiler being installed as `closure`
        if system("closure --compilation_level SIMPLE_OPTIMIZATIONS --js public/js/#{ m[1] }.js --js_output_file public/js/#{ m[1] }.min.js")
          puts "compiled and closured #{ m[1] }.coffee" 
        end
      end
    end
  end # /shell
end # /group :assets
