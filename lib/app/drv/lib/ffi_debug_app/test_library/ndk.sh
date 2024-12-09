echo "========== Build All started =========="
echo ""

echo "Preparing working files and directories"

#Create directories and copy library files to working directory
{
    find . -name "bin/android" -type d -exec rm -rf "{}" \;
    find . -name "tmp" -type d -exec rm -rf "{}" \;
#    mkdir bin
    mkdir bin/android
    mkdir tmp
    mkdir tmp/sourceFiles
    mkdir tmp/Android

    find . -name "*.c" -exec cp {} tmp/sourceFiles \;
    find . -name "*.h" -exec cp {} tmp/sourceFiles \;
} &> /dev/null

declare -a AndroidArchitectures=("x86" "x86_64" "arm" "arm64")

USER="itouyosh"
LibraryName="test"
Android_NDK_Host_Tag="windows-x86_64"
Android_Minimum_Api_Version="21"

echo ""
echo "=== BUILD TARGET (Android) ==="
echo ""

cd tmp

LibPath=${PWD}/sourceFiles

if [ -z "${ANDROID_NDK_HOME}" ]
then
    export ANDROID_NDK_HOME="/C/Users/itouyosh/AppData/Local/Android/Sdk/ndk/25.1.8937393"
fi

for i in "${AndroidArchitectures[@]}"
    do
        echo "Build for $i:"

        ABI_Folder_Name=$i

        if [ $i == "arm" ]
        then
            ABI_Folder_Name="armeabi-v7a"
        elif [ $i == "arm64" ]
        then
            ABI_Folder_Name="arm64-v8a"
        fi

        mkdir ../bin/Android/$ABI_Folder_Name     

        if [ $i == "x86" ]
        then
            CxxTarget="i686-linux-android"
        elif [ $i == "x86_64" ]
        then
            CxxTarget="x86_64-linux-android"
        elif [ $i == "arm" ]
        then
            CxxTarget="armv7a-linux-androideabi"
        else
            CxxTarget="aarch64-linux-android"
        fi

        CxxTarget="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$Android_NDK_Host_Tag/bin/$CxxTarget$Android_Minimum_Api_Version-clang"

        export CXX=$CxxTarget

        echo "Compiling and linking (output as dynamic library)"

        for i2 in $LibPath/*.c; do
            ShortName="${i2##*/}"
            OutputName="${ShortName/cpp/o}"
            $CXX -c -fPIC $i2 ${PWD}/sourceFiles/$OutputName
        done
        
        #read -p "Press [Enter] key to resume."

        $CXX -shared -o ${PWD}/sourceFiles/lib${LibraryName}.so ${PWD}/*.o

        echo "Copying lib${LibraryName}.so to bin/Android/$ABI_Folder_Name"
        {
            find sourceFiles -name "*.so" -exec cp {} ../bin/Android/$ABI_Folder_Name \;
        } &> /dev/null

        echo ""

    done

cd ..
echo "** BUILD SUCCEEDED (Android) **"
echo ""      

echo "========== Build All completed =========="
echo ""

cd ..

#Cleanup working directories
{
    find . -name "tmp" -type d -exec rm -rf "{}" \;
} &> /dev/null