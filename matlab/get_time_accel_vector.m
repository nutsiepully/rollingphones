function [ t_accel ] = get_time_accel_vector ( accel_list, activity_list, activity_id, subject_list, subject_id )
    inds = find(activity_list == activity_id);
    
    if (nargin == 5)
        inds_person = find(subject_list == subject_id);
        inds = intersect(inds_person, inds);
    end
    
    % Doesn't take overlapping into account.
    extracted_accels = accel_list(inds, :);
    t_accel = extracted_accels(:, 64:end);
    t_accel = t_accel(:);
end
