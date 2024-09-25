const notifications = await Service.import("notifications");
import Notification from "./notification.js";

const WINDOW_NAME = "ags-notifications";

const Popups = () =>
  Widget.Box({
    class_name: "spacing-5",
    vertical: true,
    hpack: "end",
    attribute: {
      map: new Map(),

      dismiss: (box: any, id: number) => {
        if (!box.attribute.map.has(id)) return;

        const notif = box.attribute.map.get(id);
        notif.attribute.count--;

        if (notif.attribute.count <= 0) {
          box.attribute.map.delete(id);
          notif.attribute.destroyWithAnims();
        }
      },

      notify: (box: any, id: number) => {
        const notif = notifications.getNotification(id);

        if (notifications.dnd || !notif) return;

        const replace = box.attribute.map.get(id);

        if (!replace) {
          const notification = Notification(notif);

          box.attribute.map.set(id, notification);

          notification.attribute.count = 1;
          box.pack_start(notification, false, false, 0);
        } else {
          const notification = Notification(notif, true);

          notification.attribute.count = replace.attribute.count + 1;

          box.remove(replace);
          replace.destroy();
          box.pack_start(notification, false, false, 0);
          box.attribute.map.set(id, notification);
        }
      },
    },
  })
    .hook(notifications, (box, id) => box.attribute.notify(box, id), "notified")
    .hook(
      notifications,
      (box, id) => box.attribute.dismiss(box, id),
      "dismissed",
    )
    .hook(notifications, (box, id) => box.attribute.dismiss(box, id), "closed");

const PopupList = () =>
  Widget.Box({
    class_name: "notifications-popup-list",
    css: "padding: 1px 0px 1px 1px;",
    children: [Popups()],
  });

export default () =>
  Widget.Window({
    name: WINDOW_NAME,
    layer: "overlay",
    anchor: ["top", "right"],
    child: PopupList(),
    visible: false,
  }).hook(
    notifications,
    () => {
      if (notifications.popups.length > 0) App.openWindow(WINDOW_NAME);
      else App.closeWindow(WINDOW_NAME);
    },
    "notify::popups",
  );
