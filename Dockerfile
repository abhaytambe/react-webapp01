#install the image for container
FROM node:lts-alpine as Builder_Phase

#set the working directory for container
WORKDIR '/usr/app'

#copy package.json file
COPY package.json .

#install and build dependencies
RUN npm install

#copy files to build the project
#Note: files are copied in PROD and not mapper so that we can deploy the code directly from the build folder

COPY . .

#run build
RUN npm run build

FROM nginx 
EXPOSE 80
COPY --from=Builder_Phase /usr/app/build /usr/share/ngnix