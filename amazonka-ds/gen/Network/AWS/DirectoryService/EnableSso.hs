{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.DirectoryService.EnableSso
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Enables single-sign on for a directory.
--
-- <http://docs.aws.amazon.com/directoryservice/latest/devguide/API_EnableSso.html>
module Network.AWS.DirectoryService.EnableSso
    (
    -- * Request
      EnableSso
    -- ** Request constructor
    , enableSso
    -- ** Request lenses
    , esrqUserName
    , esrqPassword
    , esrqDirectoryId

    -- * Response
    , EnableSsoResponse
    -- ** Response constructor
    , enableSsoResponse
    -- ** Response lenses
    , esrsStatus
    ) where

import           Network.AWS.DirectoryService.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Contains the inputs for the EnableSso operation.
--
-- /See:/ 'enableSso' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'esrqUserName'
--
-- * 'esrqPassword'
--
-- * 'esrqDirectoryId'
data EnableSso = EnableSso'
    { _esrqUserName    :: !(Maybe Text)
    , _esrqPassword    :: !(Maybe (Sensitive Text))
    , _esrqDirectoryId :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'EnableSso' smart constructor.
enableSso :: Text -> EnableSso
enableSso pDirectoryId_ =
    EnableSso'
    { _esrqUserName = Nothing
    , _esrqPassword = Nothing
    , _esrqDirectoryId = pDirectoryId_
    }

-- | The username of an alternate account to use to enable single-sign on.
-- This is only used for AD Connector directories. This account must have
-- privileges to add a service principle name.
--
-- If the AD Connector service account does not have privileges to add a
-- service principle name, you can specify an alternate account with the
-- /UserName/ and /Password/ parameters. These credentials are only used to
-- enable single sign-on and are not stored by the service. The AD
-- Connector service account is not changed.
esrqUserName :: Lens' EnableSso (Maybe Text)
esrqUserName = lens _esrqUserName (\ s a -> s{_esrqUserName = a});

-- | The password of an alternate account to use to enable single-sign on.
-- This is only used for AD Connector directories. See the /UserName/
-- parameter for more information.
esrqPassword :: Lens' EnableSso (Maybe Text)
esrqPassword = lens _esrqPassword (\ s a -> s{_esrqPassword = a}) . mapping _Sensitive;

-- | The identifier of the directory to enable single-sign on for.
esrqDirectoryId :: Lens' EnableSso Text
esrqDirectoryId = lens _esrqDirectoryId (\ s a -> s{_esrqDirectoryId = a});

instance AWSRequest EnableSso where
        type Sv EnableSso = DirectoryService
        type Rs EnableSso = EnableSsoResponse
        request = postJSON
        response
          = receiveJSON
              (\ s h x ->
                 EnableSsoResponse' <$> (pure (fromEnum s)))

instance ToHeaders EnableSso where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("DirectoryService_20150416.EnableSso" ::
                       ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON EnableSso where
        toJSON EnableSso'{..}
          = object
              ["UserName" .= _esrqUserName,
               "Password" .= _esrqPassword,
               "DirectoryId" .= _esrqDirectoryId]

instance ToPath EnableSso where
        toPath = const "/"

instance ToQuery EnableSso where
        toQuery = const mempty

-- | Contains the results of the EnableSso operation.
--
-- /See:/ 'enableSsoResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'esrsStatus'
newtype EnableSsoResponse = EnableSsoResponse'
    { _esrsStatus :: Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'EnableSsoResponse' smart constructor.
enableSsoResponse :: Int -> EnableSsoResponse
enableSsoResponse pStatus_ =
    EnableSsoResponse'
    { _esrsStatus = pStatus_
    }

-- | FIXME: Undocumented member.
esrsStatus :: Lens' EnableSsoResponse Int
esrsStatus = lens _esrsStatus (\ s a -> s{_esrsStatus = a});