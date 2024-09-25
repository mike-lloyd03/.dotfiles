import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import Notification from "./notification.js";
import PopupNotifications from "./popupNotification.js";
import NotificationList from "./notificationList.js";

const NotificationsIndicator = () =>
  Widget.Icon({
    icon: "user-available-symbolic",
    class_name: "notification-indicator",
    visible: Notifications.bind("notifications").transform(
      (nots) => nots.length > 0,
    ),
  });

const DNDIndicator = () =>
  Widget.Icon({
    icon: "notifications-disabled-symbolic",
    class_name: "notification-indicator",
    visible: Notifications.bind("dnd"),
  });

export const NotificationIndicator = () =>
  Widget.Box({
    class_name: "notification-indicator-container",
    children: [NotificationsIndicator(), DNDIndicator()],
  });

export { Notification, PopupNotifications };
export default NotificationList;
