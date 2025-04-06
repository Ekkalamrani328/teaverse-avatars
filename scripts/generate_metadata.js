const fs = require('fs');
const path = require('path');

const imagesDir = './images';
const metadataDir = './metadata';

if (!fs.existsSync(metadataDir)) {
  fs.mkdirSync(metadataDir);
}

fs.readdirSync(imagesDir).forEach((file) => {
  const id = path.parse(file).name;
  const metadata = {
    name: `TeaVerse Avatar #${id}`,
    description: "An open-source identity avatar for Tea Protocol contributors.",
    image: `images/${file}`,
    attributes: [
      { trait_type: "Role", value: "Contributor" },
      { trait_type: "Protocol", value: "Tea Protocol" }
    ]
  };

  fs.writeFileSync(
    `${metadataDir}/${id}.json`,
    JSON.stringify(metadata, null, 2)
  );
});

console.log("✅ Metadata generated for all avatars.");
