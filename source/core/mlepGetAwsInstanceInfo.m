function EC2_info = mlepGetAwsInstanceInfo ( amazonEC2Client )
%LISTAWSINSTA Summary of this function goes here
%   Detailed explanation goes here
disp('===========================================');
disp('Getting Info from AWS');
disp('===========================================');

try
    % Availability Zones
    availabilityZonesResult = amazonEC2Client.describeAvailabilityZones();
    availabilityZonesResult.getAvailabilityZones().size();
    
    % Describe Instances
    describeInstancesRequest = amazonEC2Client.describeInstances();
    reservations = describeInstancesRequest.getReservations();
    if isempty(reservations.isEmpty())
        disp('No Reservations Running');
    else
        count = 0;
        for i = 1:reservations.size
            instances = reservations.get(i-1).getInstances();
            for j = 1:instances.size
                instance  = instances.get(j-1);
                if strcmp(char(instance.getState.getName),'running')
                    count = count+1;
                    %instance(count) = instances.get(0);
                    ami(count) = instance.getAmiLaunchIndex();
                    imageId(count) = instance.getImageId();
                    pubDnsName(count) = instance.getPublicDnsName();
                    instanceId(count) = instance.getInstanceId();
                    
                else
                    disp('Instance not Running');
                end
            end
            
        end
        
        disp(['You have ' num2str(count) ' Amazon EC2 Intance(s) Running'])
    end
    if(count > 0)
        EC2_info.instCount = count;
        EC2_info.imageId = char(imageId);
        EC2_info.instanceId = char(instanceId);
        EC2_info.pubDNSName = char(pubDnsName);
    else
        EC2_info.instCount = 0;
    end
catch ase
    disp(ase)
    rethrow(ase);
end
disp('===========================================');
disp('Done!');
disp('===========================================');
end

