#!/bin/sh
echo "Please enter your folder name under Enter or /exit to quit"
read -p "folder Name: " FOLDER_NAME
if [[ "$FOLDER_NAME" == "/exit" ]]; then
	exit 1;
fi

if [ ! -e "$FOLDER_NAME" ]; then
	echo "create new folder !"
	mkdir $FOLDER_NAME
fi

echo "Please enter your file name under Enter or /exit to quit"
read -p "file name: " FILE_NAME
if [[ "$FILE_NAME" == "/exit" ]]; then
	exit 1;
fi

if [ ! -f "$FILE_NAME" ]; then
	echo "I can't find anyone file !."
	exit 1;
fi

count=1
while IFS='' read -r line; do
	count=$((count+1))
done < ${FILE_NAME}
echo "the goal download amount : ${count}"
read -p "Please check ! or Enter /exit to quit: " CHECK
if [[ "$CHECK" == "/exit" ]]; then
	exit 1;
fi

echo "\n"


counter=0
echo "To Start"
while IFS='' read -r line || [[ -n "$line" ]]; do
	echo "Text read from file: $line"
	IFS=', ' read -r -a array <<< "$line"
		if [[ "${array[0]}" != "" && "${array[1]}" != "" ]]; then
			echo "url : ${array[0]}"
			echo "filename : ${array[1]}"
			# wkhtmltopdf --no-stop-slow-scripts  ${array[0]} ${FOLDER_NAME}/${array[1]}.pdf
			counter=$((counter+1))
		fi
	echo "\n"
done < ${FILE_NAME}
echo "The End \n"

echo "------------------------------------------------------------------------------------------------------------"
echo "folder name : $FOLDER_NAME"
echo "download amount : ${counter}"