: '
    Save the script locally ie "NoAvailabilityIE.sh"
    Go to the terminal, 'cd' to the location of the script, and add 'chmod u+x NoAvailabilityIE.sh' to make the file executable.
    Modify your path to add the directory where your script is located: export PATH=$PATH:/appropriate/directory

    Run script: sh NoAvailabilityIE.sh
' 
    #!/bin/bash
     
    #
    #tue and wed anyway as it is only lidl ni, could be more awkward mon/thur
    #to run: sh NoAvailabilityIE.sh
     
    rm /Users/murty/Downloads/IE.txt
    touch /Users/murty/Downloads/IE.txt
     
    query="SELECT
    'curl --write-out '||'%'||'{'||'''http_code'''||'}'||' --silent --output /dev/null -X POST -F \"Body=Sorry, ' || o.name || ' has no donations available on ' || a.date || '\"' ||' -F \"From=+353123445234\" -F \"To='||c.data|| '\" ' || '\"https://api.twilio.com/2010-04-01/Accounts/xxxx/Messages\" ' || '-u \"xxxx:xxxx\"'
    FROM
      schedule s
      JOIN organization g ON g.name = 'IE'
      JOIN organization o ON o.id = s.org_id AND o.parent_id = g.id
      JOIN location l ON l.org_id = o.id
      JOIN contact c ON c.party_id = s.party_id AND c.type = 'sms'
      JOIN alert a ON a.donor_id = o.id AND a.message = 'NoAvailability' AND a.status in ('Open', 'Cancelled') AND a.date = CURRENT_DATE
    WHERE
      s.day = EXTRACT(ISODOW FROM (SELECT TIMESTAMPTZ 'today' AT TIME ZONE 'Europe/Dublin')) AND s.status = 'Assigned' AND c.data like '+353%'
    ;"
    echo $query | psql postgres://xxxx:xxxx@xxxx.eu-west-1.compute.amazonaws.com:5432/xxxx -qt >> /Users/murty/Downloads/IE.txt
     
    while IFS='' read -r line || [[ -n "$line" ]];
    do
     
    eval $line
     
    done < /Users/murty/Downloads/IE.txt
