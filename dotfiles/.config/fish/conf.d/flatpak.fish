if status is-login
    for dir in $__fish_vendor_confdirs
        if [ -e $dir/flatpak.fish ]
            source $dir/flatpak.fish
            break
        end
    end
end
