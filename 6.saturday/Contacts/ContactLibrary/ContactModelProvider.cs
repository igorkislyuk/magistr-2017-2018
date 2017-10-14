﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Xml.Serialization;

namespace ContactLibrary
{
    sealed public class ContactModelProvider : IContactProvider
    {
        private readonly string xmlFilePath;
        private readonly XmlSerializer serializer = new XmlSerializer(typeof(List<ContactModel>));
        private readonly List<ContactModel> contactsList;

        #region Public

        public ContactModelProvider(string path)
        {
            xmlFilePath = path + @"\contacts.xml";

            if (!File.Exists(xmlFilePath))
            {
                contactsList = CreateCustomerXmlStub();
            }
            else
            {
                // if file presented
                using (var reader = new StreamReader(xmlFilePath))
                {
                    contactsList = (List<ContactModel>)serializer.Deserialize(reader);
                }
            }
        }

        public IEnumerable<ContactModel> GetAllContactModels()
        {
            return contactsList;
        }

        public ContactModel ContactModel(int id)
        {
            return contactsList.Find(model => model.ID == id);
        }

        public void UpdateContact(int id, ContactModel model)
        {
            var contactModel = ContactModel(id);

            if (contactModel != null)
            {
                contactModel.Name = model.Name;
                contactModel.Address = model.Address;
                contactModel.Phone = model.Phone;

                SaveContactList();
            }
        }

        public int AddContact(string name, string address, string phone)
        {
            var model = new ContactModel(contactsList.Count)
            {
                Name = name,
                Address = address,
                Phone = phone
            };

            contactsList.Add(model);

            SaveContactList();

            return model.ID;
        }

        public void RemoveModel(int id)
        {
            var model = contactsList.Find(arg => arg.ID == id);

            if (model != null)
            {
                contactsList.Remove(model);

                SaveContactList();
            }
        }

        #endregion

        private List<ContactModel> CreateCustomerXmlStub()
        {
            var model = new ContactModel(0)
            {
                Name = "Joe",
                Address = "Nowhere, TX 1023",
                Phone = "123-456"
            };

            return new List<ContactModel> { model };
        }

        private void SaveContactList()
        {
            using (var writer = new StreamWriter(xmlFilePath, false))
            {
                serializer.Serialize(writer, contactsList);
            }
        }

        

    }
}
