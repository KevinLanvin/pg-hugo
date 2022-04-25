#!/usr/bin/node
const fs = require("fs");

let stdin = process.openStdin();
let data = "";
stdin.on("data", function (chunk) {
  data += chunk;
});

stdin.on("end", function () {
  const raw = JSON.parse(data);
  const result = {};
  const menu = {};
  // Extract TopBar
  const { phoneNumber, contactMail, facebook, instagram, linkedin } =
    raw.data.contactTopBar.data.attributes;
  result.phoneNumber = phoneNumber;
  result.contactMail = contactMail;
  result.facebook = facebook.href;
  result.instagram = instagram.href;
  result.linkedin = linkedin.href;

  // Extract Logo
  const { url: logoUrl } = raw.data.menu.data.attributes.Logo.data.attributes;
  result.logo = logoUrl;

  // Extract Menu
  menu.header = raw.data.menu.data.attributes.Links.map((l) => ({
    name: l.label,
    url: l.href,
    identifier: camelize(l.label),
  }));

  // Write result
  fs.writeFileSync("data/header.json", JSON.stringify(result), function (err) {
    if (err) {
      return console.log("error");
    }
  });
  fs.writeFileSync(
    "config/_default/menus.json",
    JSON.stringify(menu),
    function (err) {
      if (err) {
        return console.log("error");
      }
    }
  );
});

function camelize(str) {
  return str.replace(/(?:^\w|[A-Z]|\b\w|\s+)/g, function (match, index) {
    if (+match === 0) return ""; // or if (/\s+/.test(match)) for white spaces
    return index === 0 ? match.toLowerCase() : match.toUpperCase();
  });
}
