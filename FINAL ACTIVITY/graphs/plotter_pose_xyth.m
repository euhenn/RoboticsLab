function plotter_pose_xyth(pose_xyth)
    pose = pose_xyth(1,:);
    obstacles(pose);
    plot(pose_xyth(:,1), pose_xyth(:,2))
    t = length(pose_xyth);
    pose = pose_xyth(t,:);
    obstacles(pose)
end

