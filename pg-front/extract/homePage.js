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

  const content = raw.data.homePage.data.attributes;
  result.title = content.MainTitle;
  result.banner = {
    url: content.Banner.data.attributes.url,
    alternativeText: content.Banner.data.attributes.alternativeText,
  };
  result.sections = content.sections.map((section) => ({
    title: section.Title,
    paragraph: section.paragraph,
    quote: section.quote,
    quoteAuthor: section.quoteAuthor,
    link: section.link,
    image: section.image.data.attributes,
  }));

  // Write result
  fs.writeFileSync("content/_index.md", JSON.stringify(result), function (err) {
    if (err) {
      return console.log("error");
    }
  });
});
